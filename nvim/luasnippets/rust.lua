local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions.expand")

return {
    s(
        { trig = "meguru", dscr = "めぐる式二分探索" },
        t({
            "fn binary_search<T: PartialEq + PartialOrd>(a: &[T], key: T) -> usize {",
            "    let mut ng: i64 = -1;",
            "    let mut ok: i64 = a.len() as i64;",
            "    while (ok - ng).abs() > 1 {",
            "        let mid = (ok + ng) / 2;",
            "        if a[mid as usize] >= key {",
            "            ok = mid;",
            "        } else {",
            "            ng = mid;",
            "        }",
            "    }",
            "    ok as usize",
            "}",
        })
    ),
    s(
        { trig = "divisors", dscr = "nの約数を列挙しvecで返却する" },
        t({
            "fn divisors(n: usize) -> Vec<usize> {",
            "    let mut divisors = Vec::new();",
            "    let mut divisors_rev = Vec::new();",
            "    for i in 1..=(f64::sqrt(n as f64) + 1e-9) as usize {",
            "        if n % i == 0 {",
            "            divisors.push(i);",
            "            if i != n / i {",
            "                divisors_rev.push(n / i);",
            "            }",
            "        }",
            "    }",
            "    divisors.append(&mut divisors_rev.into_iter().rev().collect());",
            "    divisors",
            "}",
        })
    ),
    s(
        { trig = "unionfind", dscr = "Union-Find" },
        t({
            "struct UnionFind {",
            "    n: usize,",
            "    parent: Vec<usize>,",
            "    size: Vec<usize>,",
            "}",
            "",
            "impl UnionFind {",
            "    fn new(n: usize) -> UnionFind {",
            "        let mut parent = vec![0; n];",
            "        for i in 0..n {",
            "            parent[i] = i;",
            "        }",
            "        let size = vec![1; n];",
            "        UnionFind { n, parent, size }",
            "    }",
            "",
            "    fn root(&mut self, x: usize) -> usize {",
            "        if x == self.parent[x] {",
            "            self.parent[x]",
            "        } else {",
            "            let res = self.root(self.parent[x]);",
            "            self.parent[x] = res;",
            "            self.parent[x]",
            "        }",
            "    }",
            "",
            "    fn unite(&mut self, x: usize, y: usize) -> bool {",
            "        let a = self.root(x);",
            "        let b = self.root(y);",
            "        if a == b {",
            "            return false;",
            "        }",
            "        if self.size[a] <= self.size[b] {",
            "            self.parent[b] = a;",
            "            self.size[a] += self.size[b];",
            "        } else {",
            "            self.parent[a] = b;",
            "            self.size[b] += self.size[a];",
            "        }",
            "        true",
            "    }",
            "",
            "    fn is_same(&mut self, x: usize, y: usize) -> bool {",
            "        self.root(x) == self.root(y)",
            "    }",
            "    fn get_size(&mut self, x: usize) -> usize {",
            "        let a = self.root(x);",
            "        self.size[a]",
            "    }",
            "",
            "    fn count_connected_components(&mut self) -> usize {",
            "        let mut st = HashSet::new();",
            "        let n = self.parent.len();",
            "        for i in 0..n {",
            "            st.insert(self.root(i));",
            "        }",
            "        st.len()",
            "    }",
            "}",
        })
    ),
}
