module Spina
  class Project < ActiveRecord::Base
    attr_accessor :old_materialized_path

    belongs_to :project_category
    belongs_to :photo
    belongs_to :photo_collection

    before_validation :set_slug
    after_save :rewrite_rule

    validates :title, :description, :project_category_id, presence: true
    validates :slug, uniqueness: true
    accepts_nested_attributes_for :photo_collection

    # scope :newest_first, -> { order('completion_date DESC') }

    def materialized_path
      "/project/#{slug}"
    end

    private

    def set_slug
      self.old_materialized_path = materialized_path
      self.slug = title.try(:parameterize)
      self.slug += "-#{self.class.where(slug: slug).count}" if self.class.where(slug: slug).where.not(id: id).count > 0
      slug
    end

    def rewrite_rule
      RewriteRule.create(old_path: old_materialized_path, new_path: materialized_path) if old_materialized_path != materialized_path
    end
  end
end
