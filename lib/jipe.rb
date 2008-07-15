# Jipe

module Jipe
  def jipe_editor_for(record, field, options = {})
    options = { :external_control => true,
      :class => record.class.to_s,
      :rows => 1 }.update(options || {})
    rclass = options[:class]
    outstr = <<-ENDDOC
      <script type="text/javascript">
        new Jipe.InPlaceEditor("#{rclass.downcase}_#{record.id}_#{field}",
          #{rclass}, #{record.id}, #{field.to_json}, {
    ENDDOC
    if options[:external_control]
      outstr += "externalControl: 'edit_#{rclass.downcase}_#{record.id}_#{field}', "
      options.delete(:external_control)
    end
    if options[:on_complete]
      outstr += "onComplete: #{options[:on_complete]}, "
      options.delete(:on_complete)
    end
    outstr += "rows: #{options[:rows]},"
    options.delete(:rows)
    
    # everything else is ajax options
    outstr += "ajaxOptions: {"
    options.each_pair do |k, v|
      outstr += "'#{escape_javascript k.to_s}': '#{escape_javascript v.to_s}',"
    end
    
    outstr += "}});\n</script>"
    return outstr
  end

  def jipe_editor(record, field, options = {})
    options = { :external_control => true,
      :class => record.class.to_s,
      :rows => 1,
      :editing => true,
      :on_complete => nil }.update(options || {})
    rclass = options[:class]
    outstr = <<-ENDDOC
      <span id="#{rclass.downcase}_#{record.id}_#{field}">
        #{record.send(field)}
      </span>
    ENDDOC
    if options[:editing]
      outstr += <<-ENDDOC
        #{ options[:external_control] ? image_tag("edit-field.png",
          { :id => "edit_#{rclass.downcase}_#{record.id}_#{field}", :plugin => 'jipe' }) : "" }
        #{ jipe_editor_for(record, field, options)}
      ENDDOC
    end
    return outstr
  end
  
  def jipe_image_toggle(record, field, true_image, false_image, options = {})
    options = {
      :class => record.class.to_s,
      :on_complete => nil,
    }.update(options || {})
    rclass = options[:class]
    value = record.send(field)
    idprefix = "#{rclass.downcase}_#{record.id}_#{field}"
    
    js_options = {}
    js_options['onComplete'] = options[:on_complete] if options[:on_complete]
    
    outstr = <<-ENDDOC
      #{image_tag true_image, :id => "#{idprefix}_true", 
          :style => (value ? "" : "display: none") }
      #{image_tag false_image, :id => "#{idprefix}_false", 
          :style => (value ? "display: none" : "") }
      <script type="text/javascript">
        new Jipe.ImageToggle("#{idprefix}_true", "#{idprefix}_false",
          #{rclass}, #{record.id}, #{field.to_json},
          #{options_for_javascript js_options});
      </script>
    ENDDOC
    return outstr
  end
end