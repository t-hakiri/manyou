| users | tasks | labels | labeling |
| --- | --- | --- | --- |
| name :string | title :string | name :string | task_id |
| email :string | content :string |  | user_id |
| password_digest :string |  |  |


*herokuのデプロイ手順*

```
heroku login
heroku create

git add .
git commit -m ""

git push heroku topic2:master
heroku run rails db:migrate
```