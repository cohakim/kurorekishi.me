## NEXT

- kpi通知用の管理ツールを統合
- deploy backend

## 作業ログ

### 2019-06-22

- 削除通知

### 2019-06-21

- 国際化対応
- sidekiqに乗り換え
- スケジュールでジョブ実行

### 2019-06-20

- frontend が一通り流れるようにする
  - ステータスダイアログを表示できるようにした

### 2019-06-16

- ECSでデプロイできるようにした
  - Service Task で起動
  - ALBでルーティング
- frontend が一通り流れるようにする
  - 全ツイート履歴は初回リリースには含めない
  - ステータス表示の途中まで
    - プログレスバーはOK
    - ダイアログを表示できるようにする

## 手順

- RDSインスタンス作る
- ALB/TargetGroup作る
- make deploy の target-group-arn を書き換える
- route53 でALBとドメイン紐付け
- make setup-cluster
