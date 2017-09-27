module ChampionshipsHelper

  def render_brackets(championship)
    html = "<ul>"
    html += render_node(championship.full_loaded_final(:player_1, :player_2))
    html += "</ul>"
    html.html_safe
  end

  def render_node(node)
    html = "<li>"
    if(node.finished?)
      html += "<span>"+node.player_1.name+" x "+node.player_2.name+"</span>"
    else
      html += "<span>"
      if(node.player_1.present?)
        if node.player_2.present?
          html += link_to(node.player_1.name, finish_bracket_path(node.id, winner_id: node.player_1_id), remote: true)
        else
          html += node.player_1.name
        end
      else
        html += "?"
      end
      html += " x "
      if(node.player_2.present?)
        if node.player_1.present?
          html += link_to(node.player_2.name, finish_bracket_path(node.id, winner_id: node.player_2_id), remote: true)
        else
          html += node.player_2.name
        end
      else
        html += "?"
      end
      html += "</span>"
    end

    if (node.children.count > 0)
      html +=  "<ul>"
      node.children.each do |child|
        html += render_node(child)
      end
      html += "</ul>"
    end
    html += "</li>"
  end

end
