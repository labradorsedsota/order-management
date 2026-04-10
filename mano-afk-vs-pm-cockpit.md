# 横向对比：mano-afk vs pm-cockpit（同一 PRD，实测数据）

> 测试项目：轻量级订单管理系统
> 对比日期：2026-04-10（最后更新：14:26）
> 数据来源：两个 GitHub repo 全量文件 + commit 时间线 + 测试报告 + 执行日志 + REVIEW.md

### 线上版本

| 版本 | 地址 | 来源 | 说明 |
|------|------|------|------|
| mano-afk 修复前 | https://labradorsedsota.github.io/order-management-buggy/ | mano-afk 全流程产出原始版 | 含时区Bug + SVG溢出 |
| mano-afk 修复后 | https://labradorsedsota.github.io/order-management/ | 人工验收修复后 | 2个Bug已修复 |
| pm-cockpit 版本 | https://labradorsedsota.github.io/order-management-lite/ | Pichai+Fabrice+Moss 流程产出 | 首版零Bug |

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
| **Bug 发现** | 0 个 | 12 个（10 自动 + 2 人工） |
| **Bug 修复** | 无需修复 | 12/12 修复（2 轮） |
| **规则进化** | 4 条流程改进项（反馈到 skill 和执行规范） | +9 条写入 rules.md |
| **部署** | GitHub Pages ✅ | GitHub Pages ✅ |

---

## 三、CUA 轨迹产出对比

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **mano-cua session 数** | **20 条**（18 初测 + 2 补测） | **18 条**（执行日志提取） |
| **平均步数/session** | 8.4 步 | 待确认 |
| **mosstid 追溯** | ✅ 每条都有 | ❌ 无 |
| **Pre-flight 合规** | ✅ 全部通过 | ❌ 无规范 |
| **session 存储** | 服务端 + TOS | 同（已验证有 session ID，TOS 落盘待确认） |
| **session 格式** | 通道 B（mano-cua 原生） | 通道 B（同） |
| **每条轨迹净成本** | 12.5h÷20 = **37.5min/条**（含全流程） | 1.5h÷18 = **5min/条**（含人工修复） |

---

## 四、质量维度深度对比

### 4.1 应用初始质量

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 首版 Bug 数 | **0** | **10**（1 High + 6 Medium + 3 Low） |
| 最终测试通过率 | **22/22 = 100%** | E2E 10/10 + 回归 pass |
| 视觉品质 | Apple 风格（PRD 第 8 章精确定义） | Indigo 商务风（自动选择） |

### 4.2 QA 未捕获的缺陷

mano-afk 全流程完成后，次日人工验收又发现 **2 个穿透整条 QA 链的 Bug**：

| Bug | 严重度 | E2E | 对抗 | 回归 | 人工 |
|-----|--------|-----|------|------|------|
| 订单号时区错误（UTC vs 本地） | 🔴 High | ❌ | ❌ | ❌ | ✅ |
| SVG 图标溢出遮挡标题 | 🟡 Medium | ❌ | ❌ | ❌ | ✅ |

pm-cockpit 版本代码审查确认**同类问题不存在**：
- 订单号：`formatDate(new Date())` → 本地时间 ✅
- 序号：`maxSeq + 1` ✅
- SVG：有宽高约束 ✅

**根因：PRD 精确度差异。** pm-cockpit 的 AC + 视觉规范约束了实现质量。

### 4.3 测试覆盖度

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 测试设计 | 22 条，L1/L2/L3 三层，关联 AC | 10 E2E + 对抗审查 |
| 边界场景 | 空状态/表单验证/localStorage 异常（全覆盖） | 对抗审查（删除保护/碰撞/时区） |
| 未覆盖 | 无（3 条 BLOCKED 已补测通过） | Visual 跳过 + 2 个环境 Bug 未检出 |

### 4.4 过程可审计性

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 轨迹可追溯到 PRD | ✅（mosstid → 测试点 → AC） | ❌ |
| 执行规范合规 | ✅（14 条规范逐条检查） | ❌ |
| 人工审核友好度 | ✅（fixture 已知、expected result 逐条列） | 🟡 |

**核心洞察：mano-afk 的 QA 盲区是「环境相关 Bug」（时区、渲染）。功能逻辑层面够用，环境层面不够。**

---

## 五、阻塞事件对比

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 阻塞类型 | Chrome JS 权限 → 3 条 BLOCKED | mano-cua API 504 超时 |
| 阻塞时长 | ~16h 隔夜 + 3h 诊断重测 | ~2.5h 挂钟等待 |
| 处理方式 | Moss 出方案 → 方案 B 失败 → 回退方案 A → 品鉴者要求 mano-cua 重测 | 静默等待 API 恢复，无主动监控 |
| 报告修正 | 多轮格式合规修正 ~1.5h | 无（报告简洁版，无合规要求） |
| 改进产出 | 4 条流程改进项写入 REVIEW.md | 无（依赖人工纪律） |

---

## 六、效率总结

| 指标 | pm-cockpit | mano-afk | 倍率 |
|------|-----------|---------|------|
| 总工时 | 12.5h | 1.5h（含人工） | **8.3x** |
| 应用构建 | ~3h | 11min | **16x** |
| 测试执行（纯 mano-cua） | ~80min | ~33min | **2.4x** |
| CUA session 产出 | 20 条 | 18 条 | 0.9x |
| 每条轨迹全流程成本 | 37.5min | 5min | **7.5x** |
| 角色数 | 4+品鉴者 | 1+人工验收 | **4x** |

---

## 七、CUA 轨迹数据验证

### session ID

| 通道 | 数量 | 来源 | 示例 |
|------|------|------|------|
| pm-cockpit | 20 条 | TEST-REPORT mosstid | `sess-20260409165810-304decc4...` |
| mano-afk | 18 条 | 执行日志提取 | `sess-20260409224138-18ff6298...` |

### 数据可检索性

- session ID：✅ 两条通道均已确认存在
- REST API GET：❌ 服务端无读取接口
- 实际存储：TOS bucket（mano-tos/trajectories/）
- 本地验证：❌ 需 TOS 访问权限

**两条通道格式一致（通道 B），进 Layer 2 管线无需区分来源。**

---

## 八、结论

### 各自不可替代的优势

**pm-cockpit 不可替代：**
- PRD 高质量 → 应用首版零 Bug
- 22/22 测试 100% 通过
- mosstid 完整追溯链 + 执行规范合规
- 项目复盘机制（REVIEW.md）→ 流程持续改进
- **适合：Eval 数据集、论文级数据、需要精确追溯的场景**

**mano-afk 不可替代：**
- 效率碾压（总工时 8.3x，构建 16x）
- 应用多样性无上限
- 自我进化（rules.md +9 条）
- 对抗审查发现深层 Bug
- **适合：批量铺覆盖、场景多样性扩展、快速迭代**

### 双通道架构

```
                  ┌─ pm-cockpit（精品）─→ 20 sessions/app ─→ 高质量、可追溯
需求池 ─→ 分发 ─→│
                  └─ mano-afk（量产） ─→ 18 sessions/app ─→ 高速度、高多样性
                                                    ↓
                                            统一 Layer 2 管线
                                     （格式对齐 → Gate 1 → 人工审核）
```

---

## 九、下一步验证项

1. **TOS 轨迹落盘验证**：获取 TOS 权限，确认 mano-afk 18 条 session 轨迹存在
2. **mano-afk 加 mosstid**：能否嵌入水印？
3. **批量稳定性**：连续跑 5 个不同需求
4. **QA 盲区补强**：加 headless 截图验收环节
5. **PRD 质量对齐实验**：给 mano-afk 喂 pm-cockpit 级 PRD
