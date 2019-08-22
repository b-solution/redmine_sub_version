class MultipleHook < Redmine::Hook::ViewListener
  render_on :view_versions_show_contextual,
            {:partial => "versions/sub_version"}
end