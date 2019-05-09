class NotificationMessage < ActiveHash::Base
  fields :id, :start, :finish

  create id: 1,
    start: 'ツイ消ししちゃお ꉂꉂƱʊ꒰>ꈊ<ૢ꒱❣❣ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消ししちゃった ꒰ •ॢ ̫ -ॢ๑꒱✩ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 2,
    start: '｡ஐஃツイ消しནʓネヾ(öᴗ<๑)｡ஐஃ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消ししたよ (◍⁃͈ᴗ•͈)४४४♡* | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 3,
    start: 'ツイ消し中 (ꈨຶꎁꈨຶ)۶" ꁖʓ╵᷅ժ ̀꒭~ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消し完了 (๑‾᷆д‾᷇๑)৳৸ᵃᵑᵏ Ꮍ৹੫ᵎ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 4,
    start: '(╭☞•́⍛•̀)╭☞ 今からツイ消ししまーっす | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消ししましたが、なにか？ ʕ •́؈•̀ ₎ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 5,
    start: 'ツイ消しせねばっ =͟͟͞͞(๑•̀ㅁ•́ฅ✧ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消し終わった (๐ ́꒪̐ꈊ͒꒪̐)ꐳ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 6,
    start: 'ツイ消しにきました ʕ•̫͡•ʕ•̫͡•ʔ•̫͡•ʔ•̫͡•ʕ•̫͡•ʔ•̫͡•ʕ•̫͡•ʕ•̫͡•ʔ•̫͡•| 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消し終わりましたー ʕु•̫͡•ʔु ✧ | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'
  create id: 7,
    start: 'ツイ消しします (˚ ˃̣̣̥ω˂̣̣̥ )  | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー',
    finish: 'ツイ消ししましたっ ˚‧º·(˚ ˃̣̣̥⌓˂̣̣̥ )‧º·˚  | 呪われしツイートを一括削除！ 黒歴史クリーナー - https://kurorekishi.me/cleaner #黒歴史クリーナー'

  def self.find_by_random
    all.sample
  end
end
