class Gif < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  attachment :gif_file, content_type: 'image/gif'
  attachment :gif
  validates :url, format: { with: URI.regexp, message: 'must be a valid URL like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif'}, if: Proc.new { |a| a.url.present? }
  validates :url, format: { with: %r{.(gif)\Z}i, message: 'must be a GIF like http://media.giphy.com/media/tlpVdqCrewXFC/giphy.gif.' }, if: Proc.new { |a| a.url.present? }
  validate :gif_or_jpg

  def gif_or_jpg
    if [gif_file, gif].count(&:blank?) == 2
    errors[:base] << ("You need to need to have something nifty in there!")
    end
  end

  def you_have_nothing?
    !gif.blank?
  end

  def there_is_something
    if you_have_nothing?
      Refile.attachment_url(self, :gif_file)
    else
      gif_file
    end
  end

end
