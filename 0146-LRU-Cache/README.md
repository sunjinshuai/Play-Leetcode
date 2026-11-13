# 146. LRU 缓存

[力扣题目](https://leetcode.cn/problems/lru-cache/) · [完整 Java 源码](Java/LRUCache.java)

## 规则与示例

LRU（Least Recently Used）在容量不足时淘汰最久未使用的数据，而不是最早插入的数据。

- `get(key)`：存在则返回值，并更新使用顺序；不存在则返回 `-1`。
- `put(key, value)`：新增或更新数据，都将它设为最近使用；新增后超过容量，就淘汰最久未使用的数据。
- 题目保证容量为正整数，要求两个操作的平均时间复杂度为 `O(1)`。

容量为 2，下面从左到右按最近使用到最久未使用排列，只展示 key：

```text
put(1, 10) → [1]
put(2, 20) → [2, 1]
get(1)     → [1, 2]，返回 10
put(3, 30) → [3, 1]，淘汰 2
get(2)     → 返回 -1，顺序不变
```

## 为什么用哈希表和双向链表

`HashMap<Integer, ListNode>` 根据 key 直接找到节点；双向链表维护使用顺序。找到节点后，可以通过它的前后连接直接摘下它，不需要遍历。

链表统一采用这个顺序：

```text
head ⇄ 最近使用 ⇄ ... ⇄ 最久未使用 ⇄ tail
```

`head` 和 `tail` 是哨兵，不存真实缓存数据，也不放进 map。所有真实数据都放在这两个边界之间。最久未使用的节点始终是 `tail.pre`。

## 1. 初始化空链表

创建节点时，构造器里的 `pre` 和 `next` 都传入了 `null`，两个哨兵还互不相连。仅设置容量不会连接节点，因此构造方法还需要：

```java
public LRUCache(int capacity) {
    this.capacity = capacity;
    head.next = tail;
    tail.pre = head;
}
```

`head.next = tail` 表示把 head 的“下一个节点”设为 tail；`tail.pre = head` 表示把 tail 的“上一个节点”设为 head。这是保存对象引用，不是复制节点。两个方向必须分别设置。

```text
空链表：head ⇄ tail
```

为什么不把数据放在 head 前面？因为我们约定 head 是起点，从 `head.next` 开始找真实数据。如果把数据放在 head 前面，按这个规则访问就会漏掉它。哨兵让首尾数据的插入、删除也能使用相同的连接操作。

## 2. 在最前面添加节点

先插入 A，再插入 B：

```text
head ⇄ tail
head ⇄ A ⇄ tail
head ⇄ B ⇄ A ⇄ tail
```

不需要在方法中指定 A 或 B，用 `head.next` 找到原来的第一个节点即可：

```java
private void addToHead(ListNode node) {
    ListNode first = head.next;

    node.pre = head;
    node.next = first;
    first.pre = node;
    head.next = node;
}
```

当传入 B 时，`first` 就是 A；空链表时，`first` 就是 tail，所以同一段代码也适用。

### 为什么先保存 head.next

`head.next` 原本指向 A，修改后就指向 B。如果还没保存旧节点就这样写：

```java
head.next = node;
ListNode first = head.next; // 拿到的是 node 自己
node.next = first;          // 节点错误地指向自己
```

就无法正确连接原来的第一个节点。准确地说，`head.next = node` 不一定必须放最后；先保存旧的 `head.next` 后，也可以提前更新。放在最后更便于理解。

`addToHead` 接收新节点或已从链表摘下的节点。已经在链表里的节点必须先摘下，再重新插入。

## 3. 摘下节点

让目标节点的前后两个节点直接连接：

```text
摘下前：prev ⇄ node ⇄ next
摘下后：prev ⇄ next
```

```java
private void removeNode(ListNode node) {
    ListNode prev = node.pre;
    ListNode next = node.next;

    prev.next = next;
    next.pre = prev;
}
```

这里只摘下真实数据节点，不摘下哨兵。节点对象仍然存在，map 也没有被修改。该实现没有清空节点自身的旧连接；重新插入时会覆盖它们。

把已有节点变成最近使用，只需：

```java
removeNode(node);
addToHead(node);
```

## 4. get：查找、移动、返回

```java
public int get(int key) {
    ListNode node = map.get(key);
    if (node == null) {
        return -1;
    }

    removeNode(node);
    addToHead(node);
    return node.value;
}
```

访问 A 后，`head ⇄ B ⇄ A ⇄ tail` 变成 `head ⇄ A ⇄ B ⇄ tail`。map 存的仍是同一个节点引用，移动时不需要更新 map。

## 5. put：更新或新增，必要时淘汰

```java
public void put(int key, int value) {
    ListNode node = map.get(key);
    if (node != null) {
        node.value = value;
        removeNode(node);
        addToHead(node);
        return;
    }

    node = new ListNode(key, value, null, null);
    addToHead(node);
    map.put(key, node);

    if (map.size() > capacity) {
        ListNode oldest = tail.pre;
        removeNode(oldest);
        map.remove(oldest.key);
    }
}
```

更新已有 key 不增加数量，但要刷新使用顺序。新增时同时加入链表和 map；淘汰时也必须从两处删除，否则 `get` 仍能在 map 中找到已淘汰的节点。

这也是节点要保存 key 的原因：通过 `tail.pre` 找到待淘汰节点后，需要它的 key 删除 map 中的记录。

## 空指针与连接检查

如果 `removeNode` 在 `next.pre = prev` 报空指针，说明当前节点的 `next` 是 null。真实数据节点即使排在最后，也应该连接到 tail。

检查以下位置，而不是添加 `if (next != null)` 跳过操作：

1. 构造方法是否连接了 head 和 tail。
2. `addToHead` 是否设置了 `node.pre` 和 `node.next`，是否先保存旧的第一个节点。
3. 是否只对链表内的真实数据节点调用 `removeNode`，没有错误地操作哨兵或尚未加入链表的节点。
4. 淘汰时是否同时删除 map 记录。

## 复杂度

`get` 和 `put` 各执行常数次哈希表操作和链表连接操作，平均时间复杂度为 `O(1)`。最多保存 capacity 个真实节点，空间复杂度为 `O(capacity)`。
