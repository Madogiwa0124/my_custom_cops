# My Custom Cop :cop:

## Custom roules

### UseSelectInWhere

Use `select` instead of `pluck` in where to use subqueries to reduce SQL executions.

``` ruby
# bad
Foo.where(id: Bar.pluck(:foo_id))

# good
Foo.where(id: Bar.select(:foo_id))
```

### UseSanitizedSqlLike

Use sanitize_sql_like when execute `LIKE` query in where.

``` ruby
# bad
Foo.where('title LIKE ?', "%#{title}%")

# good
Foo.where('title LIKE ?', "%#{sanitized_sql_like(title)}%")
```
