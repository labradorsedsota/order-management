# 轻量级订单管理系统

内部小团队订单管理工具，替代 Excel 手工记录。单个 HTML 文件，纯前端，数据存 localStorage。

## Requirements

### Core Features
- **仪表盘统计**: 今日订单数、待处理订单数、本月销售额等关键指标卡片
- **订单管理**: 新建、编辑、删除订单；状态单向流转（待确认→已确认→生产中→已发货→已完成）
- **客户配置**: 维护客户信息（名称、联系人、电话、公司、地址），下单时可选
- **商品配置**: 维护商品信息（名称、SKU、单价、单位、分类），下单时可选
- **搜索与筛选**: 按状态、客户、日期等条件筛选订单列表
- **导出**: 点击后提示"已导出成功"即可，无需实际生成文件
- **内置假数据**: 客户、商品、订单各若干条，打开即可体验

### Decision Checklist
| Decision | Chosen | Alternatives Considered | Reasoning | Source |
|---|---|---|---|---|
| Frontend | Single HTML + vanilla JS + CSS | React SPA, Vue SPA | 用户要求单个 HTML 文件，无外部依赖 | User requirement |
| Backend | None | Express, FastAPI | 用户要求纯前端 | User requirement |
| Database | localStorage | IndexedDB, SQLite via WASM | 用户要求 localStorage | User requirement |
| Styling | CSS custom properties, inline `<style>` | Tailwind, Bootstrap | 无外部依赖约束 | User requirement, `preferences.md #6` |
| Icons | Inline SVG functions | Lucide, Font Awesome, Emoji | 无外部依赖；`preferences.md #3` 要求不用 emoji 做功能 UI | `preferences.md #3` (adapted) |
| Color Palette | Indigo primary (商务信任感) | Green, Teal, Blue | 订单管理是商务工具，蓝紫色系传达专业与信任 | `preferences.md #5` |
| Layout | Fixed sidebar + scrollable main | Top nav + tabs | 桌面端应用感，导航始终可见 | `preferences.md #10, #12` |
| Typography | System font stack | Custom fonts | 简洁快速 | `preferences.md #7` |
| Spacing | 4px/8px base unit | Arbitrary | 一致性 | `preferences.md #9` |
| Dark mode | Not included | CSS variable toggle | 用户未要求，桌面端办公场景以浅色为主 | `default` |

### Styling
- **Color scheme**: Indigo primary (#4F46E5), full scale from 50-900, semantic colors (success/warning/error/info)
- **Layout**: Fixed dark sidebar (240px) + header bar + scrollable content area, max-width 1200px for content
- **Typography**: System font stack, 3-level hierarchy (heading 24px/18px, body 14px, caption 12px)
- **Spacing**: 8px base unit, consistent multiples

## Architecture

### Tech Stack
| Layer | Technology | Reason |
|---|---|---|
| Frontend | Vanilla HTML/CSS/JS | Single file, no build step, no dependencies |
| Backend | None | Pure frontend requirement |
| Database | localStorage | Browser-native, persistent, no setup |
| Deployment | Static file serve (`npx serve` or `open`) | Single HTML file |

### Data Model
| Entity | Fields |
|---|---|
| Customer | id (string), name (string), contact (string), phone (string), company (string), address (string), createdAt (ISO string) |
| Product | id (string), name (string), sku (string), price (number), unit (string), category (string), createdAt (ISO string) |
| Order | id (string), orderNo (string), customerId (string), items (array of {productId, productName, quantity, price, subtotal}), totalAmount (number), status (enum), notes (string), createdAt (ISO string), updatedAt (ISO string) |

### Status Enum
`pending` → `confirmed` → `producing` → `shipped` → `completed`
(待确认 → 已确认 → 生产中 → 已发货 → 已完成)

### File Structure
```
order-management/
├── index.html           # Complete application (HTML + CSS + JS)
├── README.md            # Documentation
├── progress.md          # Build progress tracking
├── .gitignore           # Git ignore rules
└── deploy/
    └── start.sh         # One-command startup script
```

## Setup & Deployment

```bash
./deploy/start.sh
```

## Test Cases

### Lint
- Inline CSS/JS within HTML — manual review for unused styles and consistent conventions

### Visual Tests
| ID | Page | URL | Expected Content | Expected Layout |
|---|---|---|---|---|
| vis_1 | Dashboard | / (default view) | 4 KPI cards (今日订单、待处理、本月销售额、本月订单), recent orders table | Cards in row, table below |
| vis_2 | Orders | Orders view | Order list table with filters (status, customer, date range, search), action buttons | Filter bar above table, pagination |
| vis_3 | Customers | Customers view | Customer list table, add button | Clean table with hover states |
| vis_4 | Products | Products view | Product list table, add button | Clean table with hover states |
| vis_5 | Order Form | Modal dialog | Customer select, product item rows, quantity, auto-calculated totals, notes | Centered modal, form validation |
| vis_6 | Order Detail | Modal dialog | Order info, status progress bar, item list, action buttons | Larger modal, clear hierarchy |
| vis_7 | Empty State | After clearing data | Meaningful empty state with icon and CTA | Centered, descriptive |

### E2E Tests (VLA via mano-cua)
| ID | Command | Expected Result |
|---|---|---|
| e2e_1 | Open app, verify dashboard loads with KPI cards showing numbers | Dashboard displays 4 metric cards with non-zero values |
| e2e_2 | Navigate to Orders, verify order list displays with fake data | Order table shows multiple rows with status badges |
| e2e_3 | Click "新建订单", fill form (select customer, add product, set quantity), submit | New order appears in list with status "待确认" |
| e2e_4 | Click an order to view detail, click advance status button | Order status changes from 待确认 to 已确认 |
| e2e_5 | Navigate to Customers, click "新增客户", fill and submit | New customer appears in customer list |
| e2e_6 | Navigate to Products, click "新增商品", fill and submit | New product appears in product list |
| e2e_7 | On Orders page, filter by status "生产中" | Only orders with 生产中 status shown |
| e2e_8 | Click "导出" button on orders page | Toast notification shows "已导出成功" |
| e2e_9 | Edit an existing order, change notes, save | Order detail shows updated notes |
| e2e_10 | Delete an order, confirm deletion | Order removed from list, dashboard numbers update |

### Adversary Tests
Designed and executed by independent sub-agent based on this README. Up to 10 test cases covering edge cases, error handling, and spec compliance.
