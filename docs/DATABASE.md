# 掲示板システム データベース設計

## テーブル一覧

- users（ユーザーテーブル）
- boards（ボードテーブル）
- chat_threads（スレッドテーブル）
- posts（投稿テーブル）
- 【保留】boards（掲示板テーブル）
- 【保留】attachments（添付ファイル管理テーブル）

## ER 図

```mermaid
erDiagram
users {
  INT          user_id
  VARCHAR(255) username
  VARCHAR(255) email
  VARCHAR(255) password
  VARCHAR(255) display_name
  TIMESTAMP    created_at
  TIMESTAMP    updated_at
}

boards {
  INT          board_id
  VARCHAR(255) title
  VARCHAR(255) description
  TIMESTAMP    created_at
  TIMESTAMP    updated_at
}

chat_threads {
  INT          chat_thread_id
  INT          user_id
  INT          board_id
  VARCHAR(255) title
  VARCHAR(255) description
  TIMESTAMP    created_at
  TIMESTAMP    updated_at
}

posts {
  INT       post_id
  INT       chat_thread_id
  INT       user_id
  TEXT      content
  TIMESTAMP created_at
  TIMESTAMP updated_at
  TIMESTAMP deleted_at
}

users ||--o{ chat_threads : ""
users ||--o{ posts : ""

boards ||--o{ chat_threads : ""
chat_threads ||--o{ posts : ""
```

## users（ユーザー管理テーブル）

| カラム名     | データ型     | 制約                                                  | 説明           |
| ------------ | ------------ | ----------------------------------------------------- | -------------- |
| user_id      | INT          | PRIMARY KEY, UNIQUE KEY                               | ユーザー ID    |
| username     | VARCHAR(255) | UNIQUE, NOT NULL                                      | ユーザー名     |
| email        | VARCHAR(255) | UNIQUE, NOT NULL                                      | メールアドレス |
| password     | VARCHAR(255) | NOT NULL                                              | パスワード     |
| display_name | VARCHAR(255) |                                                       | 表示名         |
| created_at   | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                             | 作成日時       |
| updated_at   | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新日時       |

↑ にいろいろと書いたが、Rails が提供するユーザー管理に沿えれば、別にそれで構わない。

### generate コマンド

`bin/rails generate authentication`

## boards（掲示板テーブル）

| カラム名    | データ型     | 制約                                                  | 説明           |
| ----------- | ------------ | ----------------------------------------------------- | -------------- |
| board_id    | INT          | PRIMARY KEY, UNIQUE KEY                               | 掲示板 ID      |
| title       | VARCHAR(255) | NOT NULL                                              | 掲示板タイトル |
| description | VARCHAR(255) | NOT NULL                                              | 掲示板説明文   |
| created_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                             | 作成日時       |
| updated_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新日時       |

いったん board は 1 つのみとする。

### generate コマンド

`bin/rails generate model Board board_id:integer title:string description:string`

## chat_threads（スレッド管理テーブル）

| カラム名       | データ型     | 制約                                                  | 説明                      |
| -------------- | ------------ | ----------------------------------------------------- | ------------------------- |
| chat_thread_id | INT          | PRIMARY KEY, UNIQUE KEY                               | スレッド ID               |
| user_id        | INT          | FOREIGN KEY (users)                                   | スレッド作成者ユーザー ID |
| board_id       | INT          | FOREIGN KEY (users)                                   | スレッドが属する掲示板 ID |
| title          | VARCHAR(255) | NOT NULL                                              | スレッドタイトル          |
| description    | VARCHAR(255) | NOT NULL                                              | スレッド説明文            |
| created_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                             | 作成日時                  |
| updated_at     | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新日時                  |

### generate コマンド

`bin/rails generate model ChatThread chat_thread_id:integer user_id:integer board_id:integer title:string description:string`

`bin/rails generate model Thread` では以下のエラーが発生するため、chat_threads (ChatThread)とします。

```
The name 'Thread' is either already used in your application or reserved by Ruby on Rails. Please choose an alternative or use --skip-collision-check or --force to skip this check and run this generator again.
```

## posts(スレッド内の投稿管理テーブル)

| カラム名       | データ型  | 制約                                                  | 説明              |
| -------------- | --------- | ----------------------------------------------------- | ----------------- |
| post_id        | INT       | PRIMARY KEY, UNIQUE KEY                               | 投稿 ID           |
| chat_thread_id | INT       | FOREIGN KEY (chat_threads)                            | スレッド ID       |
| user_id        | INT       | FOREIGN KEY (users)                                   | 投稿者ユーザー ID |
| content        | TEXT      | NOT NULL                                              | 投稿内容          |
| created_at     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                             | 作成日時          |
| updated_at     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新日時          |
| deleted_at     | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP                           | 削除日時          |

deleted_at に日付が入っているなら「このコメントは削除されました」の表記にする。

### generate コマンド

`bin/rails generate model Post post_id:integer chat_thread_id:integer user_id:integer content:string deleted_at:timestamp`

## 【保留】attachments（添付ファイル管理テーブル）

投稿にファイルを添付できるようにしようかと思ったが、いったん後で。  
単に posts テーブルにカラムを作成して、アップロードしたファイル名 + 乱数 + timestamp で、静的アセット領域へのパスを書いておくだけでも良いかも。

## 保留にしたテーブル・機能

- 掲示板を複数にする。
- ファイル添付可能にする。attachments（添付ファイル管理テーブル）の作成
  - 単にアップロードしたファイルに + 乱数 + timestamp でリネームして保存で良い気もするが。
- 検索機能
  - Rails より SQL がどうのこうのになりそうなので保留。
