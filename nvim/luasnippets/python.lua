local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
return {
	s(
		{ trig = "pypy_recursion", name = "pypy_recursion", desc = "pypyで再帰する際のおまじない" },
		fmt(
			[[
import sys
import pypyjit
pypyjit.set_param('max_unroll_recursion=-1')
sys.setrecursionlimit(10**6)
{}
]],
			{ i(1, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "meguru", name = "meguru", desc = "めぐる式二分探索" },
		fmt(
			[[
def is_ok(x: int) -> bool:
    pass


ok = N + 1
ng = -1

while abs(ok-ng) > 1:
    mid = (ok+ng) // 2
    if is_ok(mid):
        ok = mid
    else:
        ng = mid
{}
]],
			{ i(1, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "divisors", name = "約数列挙", desc = "nの約数を列挙しlistで返却する" },
		fmt(
			[[
def get_divisors(n):
    lower, upper = [], []
    i = 1
    while i * i <= n:
        if n % i == 0:
            lower.append(i)
            if i != n // i:
                upper.append(n // i)
        i += 1
    return lower + upper[::-1]
{}
]],
			{ i(1, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "primes", name = "素数列挙", desc = "nまでの素数をlistで返却する" },
		fmt(
			[[
def get_prime(n):
    table = [i for i in range(0, n + 1)]
    prime = [True for _ in range(0, n + 1)]
    prime[0] = False
    prime[1] = False
    for d in table:
        if not prime[d]:
            continue
        for nd in range(d * d, n + 1, d):
            prime[nd] = False
        ret = []
        for d in table:
            if not prime[d]:
                continue
            ret.append(d)
        return ret
{}
]],
			{ i(1, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "factorization", name = "素因数分解", desc = "素因数分解 [[素因数,指数],...]で返却" },
		fmt(
			[[
def factorization(n):
 	ret = []
	if n == 1:
		return ret
	temp = n
	prime = get_prime(int(n**0.5) + 1)
	for i in prime:
		if temp % i == 0:
			cnt = 0
			while temp % i == 0:
				cnt += 1
				temp //= i
			ret.append([i,cnt])
	if temp != 1:
		ret.append([temp, 1])
	if ret == []:
		ret.append([n, 1])
	return ret
{}
]],
			{ i(1, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "unionfind", name = "UnionFind (num)", desc = "Union-Find" },
		fmt(
			[[
from collections import defaultdict


class UnionFind():
    def __init__(self, n):
        self.n = n
        self.parents = [-1] * n

    def find(self, x):
        if self.parents[x] < 0:
            return x
        else:
            self.parents[x] = self.find(self.parents[x])
            return self.parents[x]

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.parents[x] > self.parents[y]:
            x, y = y, x
        self.parents[x] += self.parents[y]
        self.parents[y] = x

    def size(self, x):
        return -self.parents[self.find(x)]

    def same(self, x, y):
        return self.find(x) == self.find(y)

    def members(self, x):
        root = self.find(x)
        return [i for i in range(self.n) if self.find(i) == root]

    def roots(self):
        return [i for i, x in enumerate(self.parents) if x < 0]

    def group_count(self):
        return len(self.roots())

    def all_group_members(self):
        group_members = defaultdict(list)
        for member in range(self.n):
            group_members[self.find(member)].append(member)
        return group_members

    def __str__(self):
        return "\\n".join(f"{{r}}: {{m}}" for r, m in self.all_group_members().items())

{}
]],
			{ i(0, "") },
			{ dedent = false }
		)
	),
	s(
		{
			trig = "unionfind",
			name = "Union-Find (dict)",
			desc = "Union-Find 要素にtupleや文字列可、要素数指定なし",
		},
		fmt(
			[=[
import collections
class UnionFind():
    def __init__(self):
        '''
        unionfind経路圧縮あり,要素にtupleや文字列可,始めに要素数指定なし
        '''
        self.parents = dict()                                      # 子要素:親ID,
        self.members_set = collections.defaultdict(lambda : set()) # keyが根でvalueが根に属する要素要素(tupleや文字列可)
        self.roots_set = set()                                     # 根の集合(tupleや文字列可)
        self.key_ID = dict()                                       # 各要素にIDを割り振る
        self.ID_key = dict()                                       # IDから要素名を復元する
        self.cnt = 0                                               # IDのカウンター

    def dictf(self,x): # 要素名とIDをやり取りするところ
        if x in self.key_ID:
            return self.key_ID[x]
        else:
            self.cnt += 1
            self.key_ID[x] = self.cnt
            self.parents[x] = self.cnt
            self.ID_key[self.cnt] = x
            self.members_set[x].add(x)
            self.roots_set.add(x)
            return self.key_ID[x]

    def find(self, x):
        ID_x = self.dictf(x)
        if self.parents[x] == ID_x:
            return x
        else:
            self.parents[x] = self.key_ID[self.find(self.ID_key[self.parents[x]])]
            return self.ID_key[self.parents[x]]

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if self.parents[x] > self.parents[y]:
            x, y = y, x
        if x == y:
            return
        for i in self.members_set[y]:
            self.members_set[x].add(i)
        self.members_set[y] = set()
        self.roots_set.remove(y)
        self.parents[y] = self.key_ID[x]

    def size(self, x):#xが含まれる集合の要素数
        return len(self.members_set[self.find(x)])

    def same(self, x, y):#同じ集合に属するかの判定
        return self.find(x) == self.find(y)

    def members(self, x):#xを含む集合の要素
        return self.members_set[self.find(x)]

    def roots(self):#根の要素
        return self.roots_set

    def group_count(self):#根の数
        return len(self.roots_set)

    def all_group_members(self):#根とその要素
        return {{r: self.members_set[r] for r in self.roots_set}}
{}
]=],
			{ i(0, "") },
			{ dedent = false }
		)
	),
	s(
		{ trig = "dijkstra", name = "ダイクストラ法", dscr = "ダイクストラ法" },
		fmt(
			[=[
import heapq


def dijkstra(g: list[list[tuple[int, int]]], n: int, start: int) -> list[int | float]:
"""
g:(目的node,cost)で収納
n:nodeの数
start:経路のスタート
return:
それぞれのnodeまでの最短コスト
"""
    nodes = [float("INF")] * n
    nodes[start] = 0
    next_node = []
    heapq.heappush(next_node, [start, 0])

    while len(next_node) > 0:
        _, nxt = heapq.heappop(next_node)

        for goal, cost in g[nxt]:
            if nodes[nxt] + cost < nodes[goal]:
                nodes[goal] = nodes[nxt] + cost
                heapq.heappush(next_node, [nodes[nxt] + cost, goal])
    return nodes
{}
]=],
			{ i(0, "") },
			{ dedent = false }
		)
	),
}
