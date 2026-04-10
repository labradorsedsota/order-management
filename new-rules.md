# New Rules — Learned from Order Management Bug Fixes

## R1: Sequential ID Generation Must Use max(existing) + 1
**Never** use `count + 1` or `array.length + 1` to generate sequential IDs. Deletions create gaps, and `length + 1` will collide with existing IDs. Always scan existing IDs for the maximum value and increment from there.

## R2: Delete Operations Must Check Foreign Key References
Any entity that can be referenced by other entities (e.g., products referenced by order line items, customers referenced by orders) must have reference-checking logic in the delete handler. Block deletion and show an error if references exist.

## R3: Destructive / Irreversible Actions Require Confirmation
All destructive actions (delete, status advancement that cannot be undone) must show a confirmation dialog before executing. The confirmation message must include the specific item name/ID being affected.

## R4: Date Filtering Must Use Local Timezone
Never append `'Z'` (UTC) to date boundary strings constructed from user-provided date inputs. Users expect local-timezone behavior. Use `new Date('YYYY-MM-DDT23:59:59.999')` (no Z suffix) for end-of-day boundaries.

## R5: localStorage.setItem Must Be Wrapped in try-catch
`localStorage.setItem()` can throw `QuotaExceededError`. Always wrap in try-catch with a user-facing toast/alert on failure.

## R6: Dead Code Must Be Removed, Not Left as Comments
Empty `if` blocks or conditional branches that do nothing are bugs waiting to confuse future maintainers. Either implement the logic or remove the block entirely.

## R7: Form Validation Must Not Silently Discard Invalid Rows
If a form has repeating rows (e.g., order line items) with `required` attributes, the submit handler must explicitly validate all rows. Silently filtering out invalid rows defeats the purpose of `required` and confuses users.

## R8: State-Dependent UI Must Disable Inapplicable Actions
When an entity reaches a terminal or locked state (e.g., shipped/completed orders), editing capabilities must be restricted. Disable or hide edit buttons and make key fields read-only.

## R9: Clickable Row Behavior Must Be Consistent Across Views
If a table row is clickable in one view (e.g., Dashboard), the same entity's rows in other views (e.g., Orders list) should have the same click behavior for consistency.

## R10: Action Buttons Inside Clickable Rows Need event.stopPropagation()
When a table row has an `onclick` handler and also contains action buttons (edit, delete, view), each button's `onclick` must call `event.stopPropagation()` to prevent the row click from also firing.
