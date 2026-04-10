# 横向对比：mano-afk vs pm-cockpit（同一 PRD，实测数据）

> 测试项目：轻量级订单管理系统
> 对比日期：2026-04-10
> 数据来源：两个 GitHub repo 的 commit 时间线 + 测试报告

### 线上版本

| 版本 | 地址 | 来源 | 说明 |
|------|------|------|------|
| mano-afk 修复前 | https://labradorsedsota.github.io/order-management-buggy/ | mano-afk 全流程产出原始版 | 含时区Bug + SVG溢出 |
| mano-afk 修复后 | https://labradorsedsota.github.io/order-management/ | 人工验收修复后 | 2个Bug已修复 |
| pm-cockpit 版本 | https://labradorsedsota.github.io/order-management-lite/ | Pichai+Fabrice+Moss 流程产出 | 首版零Bug |

---

## 一、时间线实测对比

### pm-cockpit 流程（order-management-lite repo）

| 时间 | 事件 | 耗时 |
|------|------|------|
| 13:57 | Pichai 提交 PRD v1.0（11章节，含 AC / 视觉规范） | — |
| 14:56 | Fabrice 提交应用代码 v1.0 | **~1h**（PRD→代码） |
| 15:41 | Moss 提交 TEST-CASE.md + 6 个 fixture 文件 | **~45min** |
| 16:55 | 修复 Pre-flight 窗口最大化问题（重测准备） | ~1h（含被作废的前轮测试） |
| 16:58 | Moss 开始第三轮正式测试 | — |
| 18:06 | 全部 22 条测试完成（19 PASS + 3 BLOCKED） | **~70min**（mano-cua 执行） |
| 18:15 | TEST-REPORT.md 提交 | — |
| 18:29 | 补齐报告缺失章节 | — |

**pm-cockpit 总耗时：13:57 → 18:29 = 4 小时 32 分钟**
**Bug 修复循环：0 次（应用一次通过，0 FAIL）**

### mano-afk 流程（order-management repo）

| 时间 | 事件 | 耗时 |
|------|------|------|
| 21:57 | 一句话需求输入 | — |
| 22:08 | 应用构建完成（74KB HTML） | **11min** |
| 22:10 | Visual 测试跳过（Vision API 500） | — |
| 22:15~23:25 | E2E 测试 10 条（含 API 504 中断 40min） | **~25min 净** |
| 23:30 | 对抗审查完成（10 findings） | **~8min** |
| 23:35 | 10/10 Bug 修复 | **4min** |
| 23:43~01:28 | 回归验证（含 API 中断） | **~8min 净** |
| 01:28 | 交付 | — |

**mano-afk 净有效时间：57 分钟**
**挂钟时间：~3.5h（含 API 中断约 2.5h）**
**Bug 修复循环：1 次（10 个 Bug，1 轮修完）**

---

## 二、产出对比（同一需求）

| 维度 | pm-cockpit（实测） | mano-afk（实测） |
|------|-------------------|-----------------|
| **PRD** | 11 章节标准 PRD（含 AC/视觉规范/风险） | README.md（需求+架构+测试定义） |
| **应用代码** | index.html（Apple 风格） | index.html 74KB（Indigo 风格） |
| **测试用例** | TEST-CASE.md（22 条，L1/L2/L3 分层） | 10 E2E + 7 Visual + 对抗审查 |
| **Fixture** | 6 个 JSON fixture 文件 | 无独立 fixture |
| **测试报告** | 8 章节标准 TR（含 mosstid/session 合规） | report.md（简洁版） |
| **Bug 发现** | 0 个（应用一次通过） | 10 个（1 High + 6 Medium + 3 Low） |
| **Bug 修复** | 无需修复 | 10/10 修复，1 轮通过 |
| **规则进化** | 无 | +9 条写入 rules.md |
| **CHANGELOG** | 无（无 Bug 无变更） | 无 |
| **部署** | GitHub Pages ✅ | GitHub Pages ✅ |

---

## 三、CUA 轨迹产出对比

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **mano-cua session 数** | 18 条（+3 BLOCKED） | 13 条（10 E2E + 3 回归） |
| **平均步数/session** | 8.4 步 | 7.3 步 |
| **总步数** | ~151 步 | ~73 步 |
| **mosstid 追溯** | ✅ 每条都有 | ❌ 无 |
| **Pre-flight 合规** | ✅ 全部通过 | ❌ 无规范 |
| **session 格式** | 通道 B（mano-cua 原生） | 通道 B（同） |
| **轨迹执行净耗时** | ~70min | ~33min（E2E 25 + 回归 8） |
| **每条轨迹净成本** | 70÷18 = **3.9min/条** | 33÷13 = **2.5min/条** |

---

## 四、质量维度深度对比

### 4.1 应用初始质量

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 首版 Bug 数 | **0** | **10**（1 High + 6 Medium + 3 Low） |
| 测试通过率 | 19/19 = **100%** | 修复前发现 10 issues → 修复后 10/10 |
| 视觉品质 | Apple 风格（PRD 第 8 章精确定义） | Indigo 商务风（自动选择） |

**解读：** pm-cockpit 的 PRD 质量高（含详细 AC + 视觉规范），Fabrice 据此开发的应用一次通过所有测试。mano-afk 没有精细 PRD，初始代码有边界遗漏，但通过对抗审查+修复循环自愈。

### 4.2 测试覆盖度

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 测试设计 | 22 条，L1/L2/L3 三层，关联 PRD AC | 10 E2E + 对抗审查 |
| 边界场景 | L3 含空状态/表单验证/localStorage 异常 | 对抗审查覆盖（删除保护/碰撞/时区） |
| 未覆盖 | 3 条 BLOCKED（环境限制） | Visual 测试跳过（API 500） |

### 4.3 过程可审计性

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 每条轨迹可追溯到 PRD | ✅（mosstid → 测试点 → AC） | ❌ |
| 执行规范合规检查 | ✅（14 条规范逐条检查） | ❌ |
| 人工审核友好度 | ✅（fixture 已知、expected result 逐条列） | 🟡（审核员需自行理解意图） |

---

## 五、效率总结

| 指标 | pm-cockpit | mano-afk | 倍率 |
|------|-----------|---------|------|
| 端到端总耗时 | 4h32min | 57min 净 | **4.8x** |
| 应用构建时间 | ~1h | 11min | **5.5x** |
| 测试执行时间 | ~70min（含 Pre-flight） | ~33min | **2.1x** |
| CUA session 产出 | 18 条 | 13 条 | 0.72x |
| 角色数 | 4（品鉴者+PM+Dev+QA） | 1 | **4x** |
| 交接次数 | 8+ | 0 | **∞** |
| 人工介入 | 2 次 | 0 次 | **∞** |

---

## 六、结论

### 各自不可替代的优势

**pm-cockpit 不可替代：**
- PRD 质量高 → 应用首版零 Bug（mano-afk 有 10 个）
- mosstid 追溯链 → 每条轨迹可定位到 PRD 验收标准
- 执行规范合规 → 轨迹质量可预期、可审计
- **适合：Eval 数据集、论文级数据、需要精确追溯的场景**

**mano-afk 不可替代：**
- 速度碾压（效率 ~5x）
- 应用多样性无上限（一句话 = 一个新应用类型）
- 自我进化（rules.md 越跑越好）
- 对抗审查发现深层 Bug（订单号碰撞、时区、引用保护）
- **适合：批量铺覆盖、场景多样性扩展、快速迭代**

### 双通道架构建议

```
                  ┌─ pm-cockpit（精品）─→ 18 sessions/app ─→ 高质量、可追溯
需求池 ─→ 分发 ─→│
                  └─ mano-afk（量产） ─→ 13 sessions/app ─→ 高速度、高多样性
                                                    ↓
                                            统一 Layer 2 管线
                                     （格式对齐 → Gate 1 → 人工审核）
```

---

## 七、质量缺陷深度对比（关键补充）

### mano-afk：自身 QA 流程未捕获的缺陷

mano-afk 完成全流程后（E2E 10/10 + 对抗审查 10 fixes + 回归 all pass），我在次日用 Chrome headless 截图做独立验收时，**又发现了 2 个 Bug**：

| Bug | 严重度 | mano-afk 的 E2E 发现了吗？ | 对抗审查发现了吗？ | 回归发现了吗？ |
|-----|--------|--------------------------|-------------------|---------------|
| 订单号日期时区错误（toISOString 返回 UTC，GMT+8 差一天）| 🔴 High | ❌ | ❌ | ❌ |
| 侧栏 SVG 图标无宽高约束导致标题文字被遮挡 | 🟡 Medium | ❌ | ❌ | ❌ |

**这两个 Bug 穿透了 mano-afk 的整条 QA 链**（E2E → 对抗 → 修复 → 回归），直到人工视觉验收才发现。

### pm-cockpit：同类问题是否存在？

对 pm-cockpit 版本（order-management-lite）代码审查：

| 对比项 | pm-cockpit 版本 | mano-afk 版本 |
|--------|----------------|---------------|
| 订单号生成 | `formatDate(new Date())` → 用 `getFullYear/getMonth/getDate`（本地时间）→ ✅ **无时区 Bug** | `toISOString().split('T')[0]` → UTC → ❌ **有时区 Bug** |
| 订单号序号 | `maxSeq + 1` → ✅ **正确** | 初始版 `length + 1` → ❌ **碰撞**（对抗审查修复后也改为 maxSeq） |
| SVG 图标 | 有明确宽高约束 → ✅ | 无宽高约束 → ❌ **溢出** |

**结论：pm-cockpit 版本在这些点上天然正确，因为 PRD 的精确定义（AC-4.2.1 + 5.1 订单编号规则）和 Apple 视觉规范（第 8 章）约束了 Fabrice 的实现质量。**

### 质量差距根因分析

| 维度 | pm-cockpit | mano-afk | 差距原因 |
|------|-----------|---------|----------|
| 首版 Bug 数 | 0 | 10 | PRD 精确度差异（11 章节 AC vs README 概述） |
| QA 后残留 Bug | 0 | 2 | mano-afk 的 E2E 只验功能逻辑，不验时区/视觉渲染 |
| 总修复轮数 | 0 | 2（对抗+人工验收） | — |
| 最终交付质量 | ✅ 无已知缺陷 | ✅ 修复后无已知缺陷 | 趋同，但 mano-afk 多了 2 轮修复成本 |

**核心洞察：mano-afk 的 QA 盲区是「环境相关 Bug」（时区、渲染）。这类 Bug 需要在真实浏览器环境中用视觉验收才能暴露，mano-cua 的 E2E 测试在功能逻辑层面是够的，但在环境层面不够。**

---

## 八、CUA 轨迹数据（补充说明）

mano-afk 调用 mano-cua 时，session 数据存储在服务端（mano.mininglamp.com），与 pm-cockpit 的 Moss 调用走相同通道。每个 session 有唯一 session_id，可通过 TOS bucket（mano-tos/trajectories/）获取原始轨迹（截图 + result.json）。

两条通道的轨迹格式完全一致（通道 B），进入 Layer 2 管线无需区分来源。

---

## 九、下一步验证项

1. **mano-afk session ID 提取**：从执行日志中获取 13 条 E2E + 回归的 session_id，确认 TOS 中可检索
2. **mano-afk 加 mosstid**：能否在 mano-afk 的 mano-cua 调用中嵌入水印？
3. **批量稳定性**：连续跑 5 个不同需求，成功率和平均耗时？
4. **QA 盲区补强**：mano-afk 是否可以加入 headless 截图验收环节来捕获环境相关 Bug？
5. **PRD 质量对齐实验**：给 mano-afk 喂 pm-cockpit 级别的 PRD，首版 Bug 率是否下降？
