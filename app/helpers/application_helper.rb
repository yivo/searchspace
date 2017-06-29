module ApplicationHelper

  # Reads image from disk and returns contents.
  # relative_path must be relative to app/assets/images
  def embed_svg(relative_path)
    File.read(Rails.root.join('app/assets/images', relative_path)).html_safe
  end
end
