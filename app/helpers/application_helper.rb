module ApplicationHelper
  def embed_svg(relative_path)
    File.read(Rails.root.join('app/assets/images', relative_path)).html_safe
  end
end
