<%= hidden_field_tag "playlist[category_ids][]", @playlist.categories.ids %>

    <%= hidden_field_tag "playlist[song_ids][]", @playlist.song_ids %>

    <%= f.collection_check_boxes :category_ids, Category.select {|c| c.name != nil }, :id, :name %><p>