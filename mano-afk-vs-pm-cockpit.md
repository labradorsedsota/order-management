# 横向对比：mano-afk vs pm-cockpit（同一 PRD，实测数据）

> 测试项目：轻量级订单管理系统
> 对比日期：2026-04-10（最后更新：14:20）
> 数据来源：两个 GitHub repo 的 commit 时间线 + 测试报告 + 执行日志

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
| 04-09 13:57 | Pichai 提交 PRD v1.0（11章节，含 AC / 视觉规范） | — |
| 04-09 14:56 | Fabrice 提交应用代码 v1.0 | **~1h**（PRD→代码） |
| 04-09 15:41 | Moss 提交 TEST-CASE.md + 6 个 fixture 文件 | **~45min** |
| 04-09 16:55 | 修复 Pre-flight 窗口最大化问题（重测准备） | ~1h（含被作废的前轮测试） |
| 04-09 16:58 | Moss 开始第三轮正式测试 | — |
| 04-09 18:06 | 22 条测试完成（19 PASS + 3 BLOCKED） | **~70min**（mano-cua 执行） |
| 04-09 18:29 | TEST-REPORT + 补齐章节 | — |
| 04-10 11:52 | L3.2/L3.3 BLOCKED → PASS（DevTools Console 方案） | **次日补测** |
| 04-10 14:05 | L3.6 BLOCKED → PASS（mano-cua 重测） | **次日补测** |
| 04-10 14:10 | CHANGELOG.md v1.0 生成，项目验收完整闭环 | — |

**pm-cockpit 总耗时：04-09 13:57 → 04-10 14:10 = 跨天（净工作约 6h）**
**Bug 修复循环：0 次（应用零缺陷）**
**BLOCKED 解决：3 条 L3 测试次日通过 DevTools Console 方案解除**

### mano-afk 流程（order-management repo）

| 时间 | 事件 | 耗时 |
|------|------|------|
| 04-09 21:57 | 一句话需求输入 | — |
| 04-09 22:08 | 应用构建完成（74KB HTML） | **11min** |
| 04-09 22:10 | Visual 测试跳过（Vision API 500） | — |
| 22:15~23:25 | E2E 测试（含 API 504 中断） | **~25min 净** |
| 23:30 | 对抗审查完成（10 findings） | **~8min** |
| 23:35 | 10/10 Bug 修复 | **4min** |
| 23:43~01:28 | 回归验证（含 API 中断） | **~8min 净** |
| 04-10 01:28 | mano-afk 流程交付 | — |
| 04-10 10:00 | 人工视觉验收发现 2 个穿透 QA 链的 Bug | **次日人工** |
| 04-10 10:30 | 修复时区 Bug + SVG 溢出，重新部署 | **~30min** |

**mano-afk 净有效时间：57 分钟（自动化部分）+ 30 分钟（人工修复）**
**挂钟时间：~3.5h（含 API 中断约 2.5h）**
**Bug 修复循环：2 次（对抗审查 10 个 + 人工验收 2 个）**

---

## 二、产出对比（同一需求）

| 维度 | pm-cockpit（实测） | mano-afk（实测） |
|------|-------------------|-----------------|
| **PRD** | 11 章节标准 PRD（含 AC/视觉规范/风险） | README.md（需求+架构+测试定义） |
| **应用代码** | index.html（Apple 风格） | index.html 74KB（Indigo 风格） |
| **测试用例** | TEST-CASE.md（22 条，L1/L2/L3 分层） | 10 E2E + 7 Visual + 对抗审查 |
| **Fixture** | 6 个 JSON fixture 文件 | 无独立 fixture |
| **测试报告** | 8 章节标准 TR（含 mosstid/session/合规检查） | report.md（简洁版） |
| **Bug 发现** | 0 个（应用一次通过） | 12 个（10 自动发现 + 2 人工发现） |
| **Bug 修复** | 无需修复 | 12/12 修复（2 轮） |
| **规则进化** | 无 | +9 条写入 rules.md |
| **CHANGELOG** | ✅ v1.0（04-10 生成） | 无 |
| **部署** | GitHub Pages ✅ | GitHub Pages ✅ |

---

## 三、CUA 轨迹产出对比

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| **mano-cua session 数** | **20 条**（18 初测 + 2 补测） | **18 条**（从执行日志提取） |
| **平均步数/session** | 8.4 步 | 待确认 |
| **总步数** | ~168 步（含补测） | 待确认 |
| **mosstid 追溯** | ✅ 每条都有 | ❌ 无 |
| **Pre-flight 合规** | ✅ 全部通过 | ❌ 无规范 |
| **session 存储** | 服务端（mano.mininglamp.com）+ TOS | 同（已验证有 session ID，TOS 落盘待确认） |
| **session 格式** | 通道 B（mano-cua 原生） | 通道 B（同） |
| **轨迹执行净耗时** | ~80min（含补测） | ~33min |
| **每条轨迹净成本** | 80÷20 = **4.0min/条** | 33÷18 = **1.8min/条** |

---

## 四、质量维度深度对比

### 4.1 应用初始质量

| 指标 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 首版 Bug 数 | **0** | **10**（1 High + 6 Medium + 3 Low） |
| 测试通过率（最终） | **22/22 = 100%** | 修复后 10/10 E2E + 回归 all pass |
| 视觉品质 | Apple 风格（PRD 第 8 章精确定义） | Indigo 商务风（自动选择） |

**解读：** pm-cockpit 的 PRD 质量高（含详细 AC + 视觉规范），Fabrice 据此开发的应用一次通过所有测试。mano-afk 没有精细 PRD，初始代码有边界遗漏，但通过对抗审查+修复循环自愈。

### 4.2 测试覆盖度

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 测试设计 | 22 条，L1/L2/L3 三层，关联 PRD AC | 10 E2E + 对抗审查 |
| 边界场景 | L3 含空状态/表单验证/localStorage 异常 | 对抗审查覆盖（删除保护/碰撞/时区） |
| 未覆盖 | 无（3 条 BLOCKED 已于次日补测通过） | Visual 测试跳过（API 500）+ 2 个环境 Bug 未检出 |

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
| 自动化净耗时 | ~6h（含次日补测） | 57min | **6.3x** |
| 应用构建时间 | ~1h | 11min | **5.5x** |
| 测试执行时间 | ~80min（含补测） | ~33min | **2.4x** |
| CUA session 产出 | 20 条 | 18 条 | 0.9x |
| 角色数 | 4（品鉴者+PM+Dev+QA） | 1（+人工验收 1） | **4x** |
| 交接次数 | 8+ | 0 | **∞** |
| 人工介入 | 2 次（checkpoint + 验收） | 1 次（人工验收修 Bug） | 2x |

---

## 六、质量缺陷深度对比

### mano-afk：自身 QA 流程未捕获的缺陷

mano-afk 完成全流程后（E2E 10/10 + 对抗审查 10 fixes + 回归 all pass），次日用 Chrome headless 截图做独立验收时，**又发现了 2 个 Bug**：

| Bug | 严重度 | E2E | 对抗审查 | 回归 | 人工验收 |
|-----|--------|-----|---------|------|---------|
| 订单号日期时区错误（toISOString 返回 UTC，GMT+8 差一天）| 🔴 High | ❌ | ❌ | ❌ | ✅ |
| 侧栏 SVG 图标无宽高约束导致标题文字被遮挡 | 🟡 Medium | ❌ | ❌ | ❌ | ✅ |

**这两个 Bug 穿透了 mano-afk 的整条 QA 链。**

### pm-cockpit：同类问题代码审查

| 对比项 | pm-cockpit 版本 | mano-afk 版本 |
|--------|----------------|---------------|
| 订单号生成 | `formatDate(new Date())` → 本地时间 → ✅ 无时区 Bug | `toISOString()` → UTC → ❌ 有时区 Bug |
| 订单号序号 | `maxSeq + 1` → ✅ 正确 | 初版 `length + 1` → ❌ 碰撞（后修复） |
| SVG 图标 | 有明确宽高约束 → ✅ | 无约束 → ❌ 溢出 |

**根因：PRD 精确度差异。** pm-cockpit 的 AC-4.2.1 + 5.1 + 第 8 章约束了实现质量。mano-afk 缺少这些约束。

### 质量差距汇总

| 维度 | pm-cockpit | mano-afk |
|------|-----------|---------|
| 首版 Bug 数 | 0 | 10 |
| QA 后残留 Bug | 0 | 2 |
| 总修复轮数 | 0 | 2 |
| 最终交付质量 | ✅ 无已知缺陷 | ✅ 修复后无已知缺陷 |

**核心洞察：mano-afk 的 QA 盲区是「环境相关 Bug」（时区、渲染）。mano-cua 的 E2E 在功能逻辑层面够用，但在环境层面不够。**

---

## 七、CUA 轨迹数据验证

### session ID

| 通道 | 数量 | 来源 | 示例 |
|------|------|------|------|
| pm-cockpit | 20 条 | TEST-REPORT.md 中 mosstid 关联 | `sess-20260409165810-304decc4...` |
| mano-afk | 18 条 | 从执行日志提取 | `sess-20260409224138-18ff6298...` |

### 数据可检索性

| 检查项 | 结果 |
|--------|------|
| session ID 是否存在 | ✅ 两条通道均有 |
| REST API GET 读取 | ❌ 服务端无 GET 接口（POST 创建/step/close 三个写操作） |
| 数据实际存储 | TOS bucket（mano-tos/trajectories/） |
| 本地直接验证 | ❌ 无 volcli/tos CLI，无法验证 TOS 中轨迹文件是否存在 |

**结论：两条通道的 mano-cua session ID 均已确认存在，格式一致（通道 B）。轨迹数据存于 TOS，需 TOS 访问权限才能验证落盘。**

---

## 八、结论

### 各自不可替代的优势

**pm-cockpit 不可替代：**
- PRD 质量高 → 应用首版零 Bug
- mosstid 完整追溯链
- 22/22 测试 100% 通过（含次日补测闭环）
- 执行规范合规 → 轨迹质量可审计
- **适合：Eval 数据集、论文级数据、需要精确追溯的场景**

**mano-afk 不可替代：**
- 速度碾压（效率 ~6x）
- 应用多样性无上限（一句话 = 一个新应用类型）
- 自我进化（rules.md 越跑越好）
- 对抗审查发现深层 Bug
- **适合：批量铺覆盖、场景多样性扩展、快速迭代**

### 双通道架构建议

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

1. **TOS 轨迹落盘验证**：获取 TOS 访问权限，确认 mano-afk 的 18 条 session 轨迹文件存在
2. **mano-afk 加 mosstid**：能否在 mano-afk 的 mano-cua 调用中嵌入水印？
3. **批量稳定性**：连续跑 5 个不同需求，成功率和平均耗时？
4. **QA 盲区补强**：mano-afk 加入 headless 截图验收环节
5. **PRD 质量对齐实验**：给 mano-afk 喂 pm-cockpit 级别的 PRD，首版 Bug 率是否下降？
