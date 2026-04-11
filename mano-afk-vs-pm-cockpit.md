# 横向对比：mano-afk vs pm-cockpit（同一 PRD，实测数据）

> 测试项目：轻量级订单管理系统
> 对比日期：2026-04-10（最后更新：2026-04-11 21:45）
> 数据来源：两个 GitHub repo 全量文件 + commit 时间线 + 测试报告 + 执行日志 + REVIEW.md + mano-cua 源码 + **TOS 轨迹原始文件（双通道实查）**

### 线上版本

| 版本 | 地址 | 来源 | 说明 |
|------|------|------|------|
| mano-afk 修复前 | https://labradorsedsota.github.io/order-management-buggy/ | mano-afk 全流程产出原始版 | 含时区Bug + SVG溢出 |
| mano-afk 修复后 | https://labradorsedsota.github.io/order-management/ | 人工验收修复后 | 2个Bug已修复 |
| pm-cockpit 版本 | https://labradorsedsota.github.io/order-management-lite/ | Pichai+Fabrice+Moss 流程产出 | Moss 测试范围内零 Bug，补充验收发现 5 个业务逻辑问题 |

---

## 一、时间线实测对比

### pm-cockpit 流程（order-management-lite repo + REVIEW.md）

| 时间 | 事件 | 耗时 |
|------|------|------|
| 04-09 13:57 | Pichai 提交 PRD v1.0（11章节） | **~2h**（含确认） |
| 04-09 14:56 | Fabrice 提交应用代码 v1.0（零缺陷） | **~3h**（含部署） |
| 04-09 15:41 | Moss 提交 TEST-CASE.md + 6 fixture | **~1.5h**（首版缺章节，后补齐） |
| 04-09 16:55 | Pre-flight 窗口最大化修复 | 含被作废的前轮测试 |
| 04-09 16:58~18:06 | Moss 执行 22 条测试（19 PASS + 3 BLOCKED） | **~1.5h** |
| 04-09 18:15~18:29 | TEST-REPORT 提交 + 补齐缺失章节 | — |
| 04-10 11:52 | L3.2/L3.3 BLOCKED→PASS（DevTools Console 方案） | **BLOCKED 诊断+重测 ~3h** |
| 04-10 12:17 | 报告格式修正（品鉴者要求 L3.6 分离 session 表） | |
| 04-10 14:05 | L3.6 BLOCKED→PASS（品鉴者要求 mano-cua 重测） | |
| 04-10 14:10 | CHANGELOG.md v1.0 | **报告修正 ~1.5h** |
| 04-10 14:19 | REVIEW.md 项目复盘 | — |

**pm-cockpit 总工时：12.5h**（REVIEW.md 记录，含 PRD 2h + 开发 3h + 测试用例 1.5h + 测试执行 1.5h + BLOCKED 处理 3h + 报告修正 1.5h）
**预估偏差：预估 8.5h → 实际 12.5h = 1.47x**（偏差主因：BLOCKED 处理和报告修正未预估）
**Bug 修复循环：0 次（应用零缺陷）**

### mano-afk 流程（order-management repo）

| 时间 | 事件 | 耗时 |
|------|------|------|
| 04-09 21:57 | 一句话需求输入 | — |
| 04-09 22:08 | 应用构建完成（74KB HTML） | **11min** |
| 04-09 22:10 | Visual 测试跳过（Vision API 500） | — |
| 22:15~23:25 | E2E 测试（含 API 504 中断） | **~25min 净** |
| 23:30 | 对抗审查（10 findings） | **~8min** |
| 23:35 | 10/10 Bug 修复 | **4min** |
| 23:43~01:28 | 回归验证（含 API 中断） | **~8min 净** |
| 04-10 01:28 | mano-afk 流程交付 | — |
| 04-10 10:00 | 人工视觉验收发现 2 个穿透 QA 链的 Bug | **次日人工** |
| 04-10 10:30 | 修复时区 Bug + SVG 溢出，重新部署 | **~30min** |

**mano-afk 自动化净耗时：57 分钟**
**含人工修复总耗时：~1.5h**
**挂钟时间：~3.5h（含 API 中断约 2.5h）**
**Bug 修复循环：2 次（对抗审查 10 个 + 人工验收 2 个）**

---

## 二、产出对比（同一需求）

| 维度 | pm-cockpit（实测） | mano-afk（实测） |
|------|-------------------|-----------------|
| **PRD** | 11 章节标准 PRD（含 AC/视觉规范/风险） | README.md（需求+架构+测试定义） |
| **应用代码** | index.html（Apple 风格，零缺陷） | index.html 74KB（Indigo 风格，首版 10 Bug） |
| **测试用例** | TEST-CASE.md（22 条，L1/L2/L3 分层，含 fixture 清单） | 10 E2E + 7 Visual + 对抗审查 |
| **Fixture** | 6 个 JSON fixture 文件 | 无独立 fixture |
| **测试报告** | 8 章节标准 TR（含 mosstid/session/合规/时间线） | report.md（简洁版） |
| **CHANGELOG** | ✅ v1.0 | 无 |
| **REVIEW（复盘）** | ✅ REVIEW.md（排期偏差/阻塞复盘/流程改进 4 项） | 无 |
| **Bug 发现（Moss 测试）** | 0 个 | 12 个（10 自动 + 2 人工） |
| **Bug 发现（补充验收）** | 5 个（业务逻辑层，详见 §4.7） | — |
| **Bug 修复** | 未修复（仅做验收记录） | 12/12 修复（2 轮） |
| **规则进化** | 4 条流程改进项（反馈到 skill 和执行规范） | +9 条写入 rules.md |
| **部署** | GitHub Pages ✅ | GitHub Pages ✅ |

---

## 三、CUA 轨迹数据对比（TOS 原始文件实查，2026-04-11）

> 数据来源：TOS bucket `mano-tos/trajectories/` 直接下载，逐 session 解析 result.json + 截图文件。

### 3.1 总量

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **唯一 session 数** | 21 | 18 |
| **总步数** | 281 | 151 |
| **总文件数** | 583 | 336 |
| **总大小** | — | 99MB |

### 3.2 完成率

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **完成率** | **21/21 = 100%** | 15/18 = 83.3% |
| **失败根因** | 无失败（3 条初测 BLOCKED 后重测通过，属流程纠偏） | 初始化失败 1 + 模型决策犹豫 1 + API 超时 1 |

### 3.3 数据结构（完全一致）

两条通道的轨迹数据结构**完全相同**：

| 文件 | 内容 | pm-cockpit | mano-afk |
|------|------|-----------|---------|
| `result.json` | task + history_resps（含 `<think>` 思考链 + `<action>` 动作）+ elapsed_time + step_count | ✅ 21/21 | ✅ 18/18 |
| `trajectory/*.png` | 每步原始屏幕截图 | 281 张 | 151 张 |
| `trajectory_visual/*.png` | 叠加动作标注的截图 | 281 张 | 149 张 |
| 思考链完整性 | `<think>...</think>` 推理过程 | 21/21 全有 | 17/18 有 |

### 3.4 数据完整性

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| step_count 与截图数一致性 | **0 mismatch** | 0 mismatch（完成的 session） |
| trajectory 与 trajectory_visual 一致性 | **281 = 281** | 151 vs 149（2 个失败 session 末步缺 visual） |
| 数据完整率 | **100%** | 98.7% |

### 3.5 步数与耗时

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 平均步数/session | **13.4** | **8.4** |
| mano-cua 总执行时间 | **77.8 min** | **32.5 min** |
| 平均耗时/session | **222s** | **108s** |

> pm-cockpit 步数较高主要来自 L3.7（CSS 逐项交叉验证，126 步 / 37 min），属于测试设计的自然产物。

### 3.6 动作类型分布

| 动作 | pm-cockpit | 占比 | mano-afk | 占比 |
|------|-----------|------|---------|------|
| left_click | 162 | 52% | 88 | 53% |
| screenshot | 32 | 10% | 8 | 5% |
| key | 32 | 10% | 21 | 13% |
| type | 31 | 10% | 12 | 7% |
| scroll | 25 | 8% | 4 | 2% |
| open_url | 2 | 1% | 11 | 7% |
| triple_click | 10 | 3% | 6 | 4% |
| right_click | 1 | 0.3% | 0 | 0% |

pm-cockpit 的 scroll（6x）、type（2.6x）、screenshot（4x）占比显著高于 mano-afk。mano-afk 以 click 为主，操作类型偏单一。

### 3.7 mosstid 追溯

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| mosstid 追溯 | ✅ 每条有（session → 测试点 → AC） | ❌ 无 |
| Pre-flight 合规 | ✅ 全部通过 | ❌ 无规范 |

---

## 四、质量维度深度对比

### 4.1 应用初始质量

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 首版 Bug 数 | **0** | **10**（1 High + 6 Medium + 3 Low） |
| 最终测试通过率 | **22/22 = 100%** | E2E 10/10 + 回归 pass |
| 视觉品质 | Apple 风格（PRD 第 8 章精确定义） | Indigo 商务风（自动选择） |

### 4.2 测试方法对比

**pm-cockpit：单一方法**

| 方法 | 数量 | 占比 | 发现 Bug |
|------|------|------|----------|
| mano-cua GUI 自动化 | 19 条（+2 补测） | 95% | 0 |
| mano-cua + 源码交叉验证 | 1 条 | 5% | 0 |

**mano-afk：混合方法**

| 方法 | 是否 mano-cua | 数量 | 发现 Bug | 说明 |
|------|-------------|------|----------|------|
| E2E 测试 | ✅ 是 | 10 条 | **0 个** | 全 PASS（含对有 Bug 应用的假阳性） |
| Visual 测试 | ❌ 截图+Vision API | 7 条 | 跳过 | API 500 未执行 |
| 对抗审查 | ❌ 纯代码审查 | 10 findings | **10 个** | 全部 Bug 来自这里 |
| 回归验证 | ✅ 是 | 3 条 | **0 个** | 修复后回归 |
| 人工视觉验收 | ❌ headless 截图 | 2 项 | **2 个** | 穿透自动化 QA 链 |

**⚠️ mano-afk 的 12 个 Bug 没有一个是 mano-cua 发现的。** 10 个来自代码级对抗审查，2 个来自人工视觉验收。

### 4.3 QA 未捕获的缺陷

mano-afk 全流程完成后，次日人工验收发现 **2 个穿透整条 QA 链的 Bug**：

| Bug | 严重度 | E2E | 对抗 | 回归 | 人工 |
|-----|--------|-----|------|------|------|
| 订单号时区错误（UTC vs 本地） | 🔴 High | ❌ | ❌ | ❌ | ✅ |
| SVG 图标溢出遮挡标题 | 🟡 Medium | ❌ | ❌ | ❌ | ✅ |

pm-cockpit 版本代码审查确认**同类问题不存在**（PRD AC + 视觉规范约束了实现质量）。

### 4.4 测试覆盖度

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 测试设计 | 22 条，L1/L2/L3 三层，关联 AC | 10 E2E + 对抗审查 |
| 边界场景 | 空状态/表单验证/localStorage 异常 | 对抗审查（删除保护/碰撞/时区） |
| 未覆盖 | **5 个业务逻辑边界（补充验收暴露）** | Visual 跳过 + 2 个环境 Bug 未检出 |

### 4.5 测试执行独立性

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **数据初始化** | ✅ 6 个 fixture JSON 预设已知状态 | ❌ 无初始化，refresh 不清 localStorage |
| **测试独立性** | ✅ 每条基于已知 fixture 状态 | ❌ 状态串联累积，后续测试依赖前序结果 |
| **浏览器生命周期** | Pre-flight 检查窗口状态 | 同一 Chrome 标签页全程复用，不关闭 |
| **数据可复现性** | ✅ 同 fixture 跑 = 同结果 | ❌ 依赖执行顺序，换序可能不同结果 |

### 4.6 补充验收：pm-cockpit 版本对抗审查（2026-04-10 15:49）

对 pm-cockpit 版本做补充验收（仅做验收记录，未改动应用）。

**视觉验收：✅ 零问题。**

**对抗代码审查：⚠️ 发现 5 个业务逻辑问题**

| # | Finding | 严重度 | mano-afk 发现？ | mano-afk 已修复？ | Moss 覆盖？ |
|---|---------|--------|------------|-------------|------------|
| P1 | 已完成订单可编辑所有字段 | Medium | ✅（U3） | ✅ | ❌ |
| P2 | 状态推进无确认步骤，误点不可逆 | Medium | ✅（U2） | ✅ | ❌ |
| P3 | 删除商品无引用保护 | Medium | ✅（U5） | ✅ | ❌ |
| P4 | 删除客户无引用保护 | Medium | 未检查 | — | ❌ |
| P5 | 删除确认弹窗不显示具体对象 | Low | ✅（U1） | ✅ | ❌ |

**pm-cockpit「首版零 Bug」修正为「Moss 测试范围内零 Bug」。** 两条通道面临同样的 mano-cua 检测能力限制——业务逻辑边界场景需要代码审查或刻意对抗性操作才能暴露。

### 4.7 pm-cockpit 测试设计规范演进（test-case-design-spec v1.0）

pm-cockpit 团队已针对 OMS 项目暴露的设计层缺陷产出了 test-case-design-spec v1.0，形成三层规范链条：

```
指派层（test-requirements.md）→ 设计层（test-case-design-spec.md）→ 执行层（mano-cua-execution-spec.md）
```

| 条款 | 命中的问题 |
|------|----------|
| **D1 边界值分析** | OMS 无边界值测试 |
| **D2 数据隔离声明** | OMS 测试间数据污染 + mano-afk 测试独立性问题 |
| **D3 状态转换否定路径** | P1（已完成可编辑）+ P2（状态推进无确认） |

pm-cockpit 的自我纠偏闭环（实践暴露缺陷 → 复盘 → 规范沉淀 → 下轮生效）是 mano-afk 不具备的结构性优势。

### 4.8 过程可审计性

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 轨迹可追溯到 PRD | ✅（mosstid → 测试点 → AC） | ❌ |
| 执行规范合规 | ✅（14 条规范逐条检查） | ❌ |
| 人工审核友好度 | ✅（fixture 已知、expected result 逐条列） | 🟡 |

---

## 五、阻塞事件对比

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 阻塞类型 | Chrome JS 权限 → 3 条 BLOCKED | mano-cua API 504 超时 |
| 阻塞时长 | ~16h 隔夜 + 3h 诊断重测 | ~2.5h 挂钟等待 |
| 处理方式 | Moss 出方案 → 方案 B 失败 → 回退方案 A → 品鉴者要求重测 | 静默等待 API 恢复 |
| 改进产出 | 4 条流程改进项写入 REVIEW.md | 无 |

---

## 六、效率总结

| 指标 | pm-cockpit | mano-afk | 倍率 |
|------|-----------|---------|------|
| 总工时 | 12.5h | 1.5h（含人工） | **8.3x** |
| 应用构建 | ~3h | 11min | **16x** |
| mano-cua 执行时间 | 77.8min | 32.5min | **2.4x** |
| CUA session 产出 | 21 条 | 18 条 | 1.2x |
| 总步数产出 | 281 步 | 151 步 | 1.9x |
| 每条轨迹全流程成本 | 35.7min | 5min | **7.1x** |
| 每条轨迹 mano-cua 成本 | 3.7min | 1.8min | **2.1x** |
| 角色数 | 4+品鉴者 | 1+人工验收 | **4x** |

---

## 七、结论

### 各自不可替代的优势

**pm-cockpit 不可替代：**
- 100% session 完成率（mano-afk 83.3%）
- 100% 数据完整性（0 mismatch）
- mosstid 完整追溯链 + 执行规范合规
- fixture 保证测试独立性和可复现性
- 动作类型更丰富（scroll 6x、type 2.6x、screenshot 4x）
- 三层规范链条 + 自我纠偏闭环
- **适合：Eval 数据集、论文级数据、需要精确追溯的场景**

**mano-afk 不可替代：**
- 全流程效率 8.3x，构建 16x
- 应用多样性无上限
- 对抗审查发现深层业务逻辑 Bug（pm-cockpit 同类问题未被 Moss 捕获）
- 天然产出 Golden + Buggy 配对轨迹
- **适合：批量铺覆盖、场景多样性扩展、快速迭代**

### 双通道架构

```
                  ┌─ pm-cockpit（精品）─→ 21 sessions/app ─→ 高质量、可追溯、可复现
需求池 ─→ 分发 ─→│
                  └─ mano-afk（量产） ─→ 18 sessions/app ─→ 高速度、高多样性、含Buggy
                                                    ↓
                                            统一 Layer 2 管线
                                     （格式对齐 → Gate 1 → 人工审核）
```

---

## 八、下一步验证项

1. **mano-afk 加 mosstid**：能否嵌入水印？
2. **批量稳定性**：连续跑 5 个不同需求
3. **QA 盲区补强**：加 headless 截图验收环节
4. **PRD 质量对齐实验**：给 mano-afk 喂 pm-cockpit 级 PRD，首版 Bug 率是否下降
5. **测试独立性改进**：mano-afk 每条测试前加 localStorage 重置或 fixture 注入
