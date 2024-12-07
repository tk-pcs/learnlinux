# Git Commit Message Standard

## Format Structure
```
<type>(<scope>): <subject>

<body>

<footer>
```

## Components

### 1. Type (Required)
One of the following:
- `feat`: New feature or functionality
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style/formatting (no code change)
- `refactor`: Code refactoring (no feature/fix)
- `perf`: Performance improvements
- `test`: Adding or modifying tests
- `chore`: Maintenance tasks, dependencies, etc.

### 2. Scope (Optional)
Indicates the section of the codebase affected, e.g.:
- Component name
- File name
- Feature area
- Module name

### 3. Subject (Required)
- Use imperative mood ("Add" not "Added" or "Adds")
- No period at the end
- Maximum 72 characters
- Start with lowercase letter

### 4. Body (Optional)
- Separate from subject with blank line
- Explain what and why vs. how
- Wrap at 72 characters
- Use imperative mood

### 5. Footer (Optional)
- Reference issues, tickets, breaking changes
- One issue reference per line
- Breaking changes must start with "BREAKING CHANGE:"

## Examples

Simple commit:
```
feat(auth): add password reset functionality
```

With body:
```
fix(api): prevent timeout on long-running queries

Implement request timeout handling to avoid server overload.
Requests exceeding 30s will return 408 status code.

Closes #123
```

Breaking change:
```
feat(api): change authentication method

Replace token-based auth with OAuth2.

BREAKING CHANGE: `authenticate()` now requires client_id parameter
Closes #456
```

## Rules
1. Each commit should contain related changes only
2. Test before committing
3. No comments in commit messages
4. Write meaningful messages that explain WHY
5. Use present tense imperative mood

## Message Formula
Test your subject line with: "If applied, this commit will..."
- Good: "If applied, this commit will add user authentication"
- Bad: "If applied, this commit will added user authentication"