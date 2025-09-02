# Fix Failing Tests and Type/Style Issues

## Instructions

Please run the following commands to identify and fix any failing tests, type check issues, and style violations:

1. First, run `dev test --include-branch-commits` to identify any failing tests
2. Run `dev tc` to check for type checking issues  
3. Run `dev style --include-branch-commits` to find and auto-fix style/linting errors

For each issue found:
- Analyze the error message carefully
- Make the necessary fixes to resolve the issue
- Re-run the relevant command(s) to verify the fix worked

Keep iterating through these steps until:
- All tests pass (`dev test --include-branch-commits` shows 0 failures)
- Type check passes (`dev tc` shows no errors)
- Style check passes (`dev style --include-branch-commits` shows no offenses)

After all checks pass, provide a brief summary report that includes:
- What issues were found
- What changes were made to fix them
- Confirmation that all checks now pass

## Important Notes

### Sorbet/Type Checking Fixes

- When you encounter `.first!` method errors on Array types, replace with `.not_nil!.first.not_nil!`
  - Arrays don't have the `.first!` convenience method from ActiveRecord
  - Use our internal helper: `.not_nil!.first.not_nil!` instead
  - The first `.not_nil!` ensures the array isn't nil
  - `.first` returns a nilable type (could be nil if array is empty)
  - The second `.not_nil!` asserts the result isn't nil
  - Example: `order.refunds.first!` → `order.refunds.not_nil!.first.not_nil!`

### Test Stubbing

- When stubbing methods in tests, ensure you're stubbing on the correct object reference
- If `refund_line_item.refund` is the actual refund being used, stub on that, not on `order.refunds.first`

### General Guidelines

- Always verify your changes don't break existing functionality
- Run all three checks (test, tc, style) after making changes
- Some style issues may be auto-fixed by the style command
- Pay attention to line numbers in error messages for quick navigation