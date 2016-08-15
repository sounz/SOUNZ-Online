module SounzmediaHelper
  
  def get_sounzmedia
    manifestation_type_sounzmedia = ManifestationType.find(:first, :conditions => ["manifestation_type_desc = 'Media on Demand'"])
    manifestations = Manifestation.find(:all, :conditions => ["manifestation_type_id =" + manifestation_type_sounzmedia.manifestation_type_id.to_s])
    resource_type_sounzmedia = ResourceType.find(:first, :conditions => ["resource_type_desc = 'Media on Demand'"])
    resources = Resource.find(:all, :conditions => ["resource_type_id =" + resource_type_sounzmedia.resource_type_id.to_s])
    @sounzmedia = manifestations | resources  
  end
  
  def get_sounzmedia_by_format(sounzmedia)
    direct = []
    embedded = []
    for m in sounzmedia
      if m.is_embedded? 
        embedded.push(m)
      else
        direct.push(m)
      end
    end
    return direct, embedded
  end

  def playlist(sounzmedia, id)    
    playlist = "<?xml version=\"1.0\" encoding=\"utf-8\"?><playlist version=\"1\"><title></title><tracklist>"
    for m in sounzmedia
      images = m.media_items
      if (!images[0].nil?) then
        image =  images[0].public_filename
      else 
        image = ''
      end
      type = "#{m.class.to_s.tableize.singularize}"
      playlist  += "<track>"
      if type == "manifestation"
        playlist          += "<title>" + m.manifestation_title +  "</title>"
      else
        playlist          += "<title>" + m.resource_title +  "</title>"
      end
      if external_formats.include?(m.format_id)
        playlist          += "<location>" + m.sounzmedia + "</location>"
      else
        playlist          += "<location>/sounzmedia/" + m.sounzmedia + "</location>"
      end
      playlist          += "<image>" + image +"</image>"
      playlist          += "<description>description</description>"
      playlist          += "</track>"
    end
    playlist  += "</tracklist></playlist>"
    File.open("public/sounzmedia/" + id.to_s + ".xml", 'w+') {|f| f.write(playlist) }
  end
  
  def append_type_to_query(query)
    manifestation_type_sounzmedia_id = ManifestationType.find(:first, :conditions => ["manifestation_type_desc = 'Media on Demand'"]).manifestation_type_id
    resource_type_sounzmedia_id = ResourceType.find(:first, :conditions => ["resource_type_desc = 'Media on Demand'"]).resource_type_id
    return query + " AND (type_for_solr_t: #{manifestation_type_sounzmedia_id} OR type_for_solr_t: #{resource_type_sounzmedia_id} OR has_sounzmedia_for_solr_t: true)"
  end
  
  def get_related_works(results)
    works = Array.new
    for obj in results
      if obj.objectType == "manifestation"
        for w in obj.objectData.related_works
          works.push(w)
        end
      elsif obj.objectType == "resource"
        for w in obj.objectData.all_associated_works
          works.push(w)
        end
      elsif obj.objectType == "work"
        works.push(obj.objectData)
      end
    end
    if works.length > 1
      works = works.uniq
    end
    
    works
  end
  
  def clean_works(results)
    result = Array.new
    for obj in results
      if obj.objectType != "work"
        result.push(obj)
      end
    end
    return result
  end
  
  def add_sounzmedia(works)
    result = Array.new
    for obj in works
      for m in obj.related_manifestations
        if m.is_a_sounzmedia?
          result.push(FrbrObject.new(m.class.name.downcase, m))
        end
      end
      for r in obj.related_resources
        if r.is_a_sounzmedia?
          result.push(FrbrObject.new(r.class.name.downcase, r))
        end
      end
    end
    return result
  end
  
end
