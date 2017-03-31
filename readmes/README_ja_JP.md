# ntp

#### 目次


1. [モジュールの説明 - モジュールの内容と有益性](#module-description)
1. [設定 - ntpを開始するにあたっての基本設定](#setup)
1. [使用事例 - 設定オプションと追加機能](#usage)
1. [参照 - モジュールのクラスやパラメータの説明](#reference)
1. [制限事項 - OSの互換性など](#limitations)
1. [開発 - モジュールへの貢献方法](#development)


## モジュールの説明

ntpモジュールは、広範なオペレーティングシステムと配備環境で、NTPサービスをインストール、設定、管理します。

## 設定

### ntpの使用開始

`include '::ntp'` と入力するだけで、使用を開始することができます。使用するサーバを指定するパラメータは、次の方法で渡します。

```puppet
class { '::ntp':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
}
```

## 使用事例

ntpモジュールのすべてのパラメータは、メインクラスである `::ntp` クラスに含まれているため、モジュールのあらゆる関数のオプションを自由に設定できます。以下の一般的な使用事例を参照してください。

### NTPをインストールして有効にする

```puppet
include '::ntp'
```

### NTPサーバを変更する

```puppet
class { '::ntp':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
}
```

### 接続できるユーザを制限する

```puppet
class { '::ntp':
  servers  => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict => ['127.0.0.1'],
}
```

### 問い合わせできないクライアントをインストールする

```puppet
class { '::ntp':
  servers   => ['ntp1.corp.com', 'ntp2.corp.com'],
  restrict  => [
    'default ignore',
    '-6 default ignore',
    '127.0.0.1',
    '-6 ::1',
    'ntp1.corp.com nomodify notrap nopeer noquery',
    'ntp2.corp.com nomodify notrap nopeer noquery'
  ],
}
```

### 特定のインターフェイスでのみ聴取する

Openstackノードには多数の仮想インターフェイスが存在する場合があるため、NTPを特定のインターフェイスに制限することが特に有用です。

```puppet
class { '::ntp':
  servers  => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  interfaces => ['127.0.0.1', '1.2.3.4']
}
```

### Puppetによるサービスの制御をオプトアウトする

```puppet
class { '::ntp':
  servers        => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict       => ['127.0.0.1'],
  service_manage => false,
}
```

### ntpをインストールせずに設定して実行する

```puppet
class { '::ntp':
  package_manage => false,
}
```

### カスタムテンプレートに渡す

```puppet
class { '::ntp':
  servers         => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict        => ['127.0.0.1'],
  service_manage  => false,
  config_epp      => 'different/module/custom.template.epp',
}
```

## 参照

### クラス

#### パブリッククラス

* ntp: ほかのすべてのクラスを含むメインクラス。

#### プライベートクラス

* ntp::install: パッケージを処理します。
* ntp::config: 構成ファイルを処理します。
* ntp::service: サービスを処理します。

### パラメータ

`::ntp` クラスでは、以下のパラメータを使用できます。

#### `authprov`

オプション

データタイプ: 文字列

NTPdの一部のバージョン(Novell DSfWなど)で、W32Timeとの互換性を確保できます。
デフォルト値: `undef`

#### `broadcastclient`

データタイプ: ブーリアン

あらゆるローカルインターフェイスでブロードキャストサーバのメッセージを受信できるようになります。

デフォルト値: `false`

#### `config`

データタイプ: Stdlib::Absolutepath

NTPの構成情報を含むファイルを指定します。

デフォルト値: '/etc/ntp.conf' (Solaris: '/etc/inet/ntp.conf')

#### `config_dir`

オプション

データタイプ: Stdlib::Absolutepath

NTP構成ファイルのディレクトリを指定します。

デフォルト値: `undef`

#### `config_epp`

オプション

データタイプ: 文字列

構成ファイルのEPPテンプレートへの絶対パスまたは相対パスを指定します(値の例: 'ntp/ntp.conf.epp')。このパラメータと`config_template`パラメータの**両方**を指定すると、検証エラーがスローされます。

####`config_file_mode`

データタイプ: 文字列

ntp構成ファイルのファイルモードを指定します。

デフォルト値: '0664'

#### `config_template`

オプション

データタイプ: 文字列

構成ファイルのERBテンプレートへの絶対パスまたは相対パスを指定します(値の例: 'ntp/ntp.conf.erb')。このパラメータと`config_epp`パラメータの**両方**を指定すると、検証エラーがスローされます。

#### `disable_auth`

データタイプ: ブーリアン

ブロードキャストクライアント、マルチキャストクライアント、対称的な受動的関係の暗号化認証を無効にします。

#### `disable_dhclient`

データタイプ: ブーリアン

`dhclient.conf`内の`ntp-servers`を無効にすることによって、DhclientがNTPの設定を管理できないようにします。

#### `disable_kernel`

データタイプ: ブーリアン

カーネルによる時刻の調整を無効にします。

#### `disable_monitor`

データタイプ: ブーリアン

NTP内のモニタリング機能を無効にします。

デフォルト値: `true`

#### `driftfile`

データタイプ: Stdlib::Absolutepath

NTP driftfileの保存場所を指定します。

デフォルト値: '/var/lib/ntp/drift' (AIX: 'ntp::driftfile:'、Solaris: '/var/ntp/ntp.drift')

#### `fudge`

オプション

データタイプ: 配列[文字列]

個々のクロックドライバの追加情報を提供します。

デフォルト値: [ ]

#### `iburst_enable`

データタイプ: ブーリアン

すべてのNTPピアのiburstオプションを有効にするかどうかを指定します。

デフォルト値: `false` (AIX、Debian: `true`)

#### `interfaces`

データタイプ: 配列[文字列]

NTPが聴取する1つ以上のネットワークインターフェイスを指定します。

デフォルト値: [ ]

#### `interfaces_ignore`

データタイプ: 配列[文字列]

NTPリスナー設定の無視パターン(例: all、wildcard、ipv6)を1つ以上指定します。

デフォルト値: [ ]

#### `keys`

データタイプ: 配列[文字列]

鍵ファイルに鍵を配布します。

デフォルト値: [ ]

#### `keys_controlkey`

オプション

データタイプ: Ntp::Key_id

ntpqユーティリティと共に使用する鍵識別子(値の範囲: 1～65,534)を指定します。

デフォルト値: ' '

#### `keys_enable`

データタイプ: ブーリアン

鍵による認証を有効にするかどうかを指定します。

デフォルト値: `false`

#### `keys_file`

Stdlib::Absolutepath.

MD5鍵ファイルの完全パスと保存場所を指定します。MD5鍵ファイルには、対称鍵暗号の使用時にntpd、ntpqおよびntpdcが使用する鍵と鍵識別子が含まれています。

デフォルト値: '/etc/ntp.keys' (RedHat、Amazon: `/etc/ntp/keys`)

#### `keys_requestkey`

オプション

データタイプ: Ntp::Key_id

ntpdcユーティリティプログラムと共に使用する鍵識別子(値の範囲: 1～65,534)を指定します。

デフォルト値: ' '

#### `keys_trusted`

オプション

データタイプ: 配列[Ntp::Key_id]

NTPが信頼している1つ以上の鍵を提供します。

デフォルト値: [ ]

#### `leapfile`

オプション

データタイプ: Stdlib::Absolutepath

NTPが使用する「うるう秒ファイル」を指定します。

デフォルト値: ' '

#### `logfile`

オプション

データタイプ: Stdlib::Absolutepath

NTPがsyslogの代わりに使用するログファイルを指定します。

デフォルト値: ' '

#### `minpoll`

オプション

データタイプ: Ntp::Poll_interval

Puppetをアップストリームサーバの規格外の最小ポーリング間隔に設定します(値: 3～16)。
デフォルト: `undef`

#### `maxpoll`

オプション

データタイプ: Ntp::Poll_interval

アップストリームサーバの規格外の最大ポーリング間隔に設定します(値: 3～16)。
デフォルトオプション: `undef`(FreeBSD: 9)

#### `ntpsigndsocket`

オプション

データタイプ: Stdlib::Absolutepath

NTPがntpsigndsocketパスのソケットを使用してパケットに署名するよう設定します。NTPがソケットに署名するよう設定されていなければなりません。値: ソケットディレクトリへのパス(例: Samba: `usr/local/samba/var/lib/ntp_signd/`)。

デフォルト値: `undef`

#### `package_ensure`

データタイプ: 文字列

NTPパッケージをインストールするかどうか、インストールする場合はどのバージョンをインストールするかを指定します(値: 'present'、'latest'、または特定のバージョン番号)。

デフォルト値: 'present'

#### `package_manage`

データタイプ: ブーリアン

NTPパッケージを管理するかどうか指定します。

デフォルト値: `true`

#### `package_name`

データタイプ: 配列[文字列]

管理するNTPパッケージを指定します。 

デフォルト値: ['ntp'] (AIX: 'bos.net.tcp.client'、Solaris: [ 'SUNWntp4r'、'SUNWntp4u' ])

#### `panic`

オプション
データタイプ: 整数[0]

クロックスキューが大きすぎる場合にNTPでパニックを発生させ終了させるかどうか指定します。この指定は`tinker`オプションが`true`に設定されている場合のみ、または仮想マシン環境でのみ適用されます。

デフォルト値: `undef` (仮想環境: 0)

#### `peers`

データタイプ: 配列[文字列]

ローカルクロックを同期させるNTPサーバのリスト

#### `preferred_servers`

データタイプ: 配列[文字列]

1つ以上の優先ピアを指定します。Puppetによって`servers`配列内の一致する項目の最後に'prefer'が追加されます。

デフォルト値: [ ]

#### `noselect_servers`

配列[文字列]で、同期させない1つ以上のピアを指定します。Puppetによって`servers`配列内の一致する項目の最後に'noselect'が追加されます。デフォルト値: [ ]     

#### `restrict`

データタイプ: 配列[文字列]

NTP設定の1つ以上の`restrict`オプションを指定します。Puppetによって各項目の先頭に'restrict'が追加されるため、リストする必要があるのは制限事項の内容のみです。

ほとんどのオペレーティングシステムのデフォルト値:

```shell
[
  'default kod nomodify notrap nopeer noquery',
  '-6 default kod nomodify notrap nopeer noquery',
  '127.0.0.1',
  '-6 ::1',
]
```

AIXシステムのデフォルト値:

```shell
[
  'default nomodify notrap nopeer noquery',
  '127.0.0.1',
]
```

#### `servers`

データタイプ: 配列[文字列]

NTPピアとして使用する1つ以上のサーバを指定します。

デフォルト値: オペレーティングシステムによって異なります。

#### `service_enable`

データタイプ: ブーリアン

起動時にNTPサービスを有効にするかどうか指定します。

デフォルト値: `true`

#### `service_ensure`

データタイプ: Enum['running'、'stopped']

NTPサービスを実行するかどうか指定します。

デフォルト値: 'running'


#### `service_manage`

データタイプ: ブーリアン

NTPサービスを管理するかどうか指定します。

デフォルト値: `true`

#### `service_name`

データタイプ: 文字列

管理対象のNTPサービス

デフォルト値: オペレーティングシステムによって異なります。

#### `service_provider`

データタイプ: 文字列

NTPに使用するサービスプロバイダ

デフォルト値: `undef`

#### `statistics`

データタイプ: 配列

ntpモニタリングが有効になっている場合に収集する統計のリスト

デフォルト値: []

#### `statsdir`

データタイプ: Stdlib::Absolutepath

NTP統計の保存先(ntpモニタリングが有効になっている場合)

デフォルト値: '/var/log/ntpstats'

#### `step_tickers_file`

オプション

データタイプ: Stdlib::Absolutepath

管理対象システム上のstep tickersファイルの保存場所

デフォルト値: オペレーティングシステムによって異なります。


####`step_tickers_epp`

オプション

データタイプ: 文字列

step tickers EPPテンプレートファイルの保存場所。このパラメータと`step_tickers_template`パラメータの両方を指定すると、検証エラーがスローされます。

デフォルト値: オペレーティングシステムによって異なります。

#### `step_tickers_template`

オプション

データタイプ: 文字列

step tickers ERBテンプレートファイルの保存場所。 このパラメータと`step_tickers_epp`パラメータの両方を指定すると、検証エラーがスローされます。

デフォルト値: オペレーティングシステムによって異なります。

#### `stepout`

オプション

データタイプ: 整数[0, 65535]

`tinker`値が`true`の場合のstepoutの値。有効なオプション: unsigned shortint digit

デフォルト値: `undef`

#### `tos`

データタイプ: ブーリアン

tosオプションを有効にするかどうかを指定します。

デフォルト値: `false`

#### `tos_minclock`

オプション

データタイプ: 整数[1]

minclock tosオプションを指定します。

デフォルト値: 3

#### `tos_minsane`

オプション

データタイプ: 整数[1]

minsane tosオプションを指定します。

デフォルト値: 1

#### `tos_floor`

オプション

データタイプ: 整数[1]

floor tosオプションを指定します。

デフォルト値: 1

#### `tos_ceiling`

オプション

データタイプ: 整数[1]

ceiling tosオプションを指定します。

デフォルト値: 15

#### `tos_cohort`


データタイプ: 変数。ブーリアン、整数[0,1]

cohort tosオプションを指定します。有効なオプション: 0または1

デフォルト値: 0

#### `tinker`

データタイプ: ブーリアン

tinkerオプションを有効にするかどうかを指定します。

デフォルト値: `false`

#### `udlc`

データタイプ: ブーリアン

Undisciplined Local Clockを時刻ソースとして使用するようNTPを設定するかどうか指定します。
デフォルト値: `false`

#### `udlc_stratum`

オプション。データタイプ: 整数[1,15]

Undisciplined Local Clockを時刻ソースとして使用する場合にサーバを実行する階層を指定します。制御下にある即時ネットワークの外部からntpdにアクセスできる場合は、この値を10以上にする必要があります。

デフォルト値: 10

## 制限事項

このモジュールは[PE対応のすべてのプラットフォーム]上でテスト済みです(https://forge.puppetlabs.com/supported#compat-matrix)。さらに、Solaris 10とFedora 20-22上でもテスト済み(ただし非対応)です。

## 開発

Puppet Forge上のPuppetモジュールは公開プロジェクトです。このモジュールの今後の進展にはコミュニティによる協力が不可欠です。変更にご協力いただける場合はガイドラインに従ってください。

詳しくは[モジュールへの貢献に関するガイド](https://docs.puppetlabs.com/forge/contributing.html)をご覧ください。

### 貢献者

すでにご協力いただいている方のリストについては、[貢献者リスト](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)をご覧ください。

