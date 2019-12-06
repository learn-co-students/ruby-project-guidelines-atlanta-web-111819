def related_comics(charac)
   tmp = Charactercomic.all.select{|rel| rel.character_id == charac.char_id}
   comix_list = tmp.map{|rel| Comic.where(comic_id: rel.comic_id)}.flatten.uniq{|i| i.comic_id}
   comix_list.each do |com|
        puts "#{com.comic_id} | #{com.name}"
   end
end

def related_character(comix)
    tmp = Charactercomic.all.select{|rel| rel.comic_id == comix.comic_id}
    chara_list = tmp.map{|rel| Character.where(char_id: rel.character_id)}.flatten.uniq{|i| i.char_id}
    chara_list.each do |char|
        puts "#{char.char_id} | #{char.name}"
    end
end

def print_relation(relat)
    comic_val = Comic.all.select{|com| com.comic_id == relat.comic_id}
    char_val = Character.all.select{|chara| chara.char_id == relat.character_id}
    puts "#{comic_val[0].comic_id} | #{comic_val[0].name} | #{char_val[0].char_id} | #{char_val[0].name}"
end