#!/usr/bin/env ../sounz/script/runner

#retrieve a work, and recursively follow all links from it, writing out nodes and edges as we encounter them.

#Node - id, type, label

@nodes=Hash.new()
@edges=Hash.new()
@id=0
@depth=0


def getId
  @id+=1
@id
end

def newEdge(source, target)
  myId=getId()
  myEdge=Hash.new()
  myEdge={'id'=> myId,'source' => source, 'target' => target}
  @edges[source.to_s+'_'+target.to_s]=myEdge
myEdge['id']
end

def newNode(db_id,name,type,label)
  myId=getId()
  myNode=Hash.new()
  myNode={'id' => myId,'name' => name, 'type' => type,'label' => label}
  @nodes[db_id.to_s+'_'+type.to_s]=myNode;
myNode['id']
end

@currentObjects=Hash.new()
@foundObjects=Hash.new()

def frbr_relationships(myObject,myObjectNodeDbId,myObjectType)
  #print ""+@depth.to_s+ "evaluating: "+myObjectType+ " "+myObject.frbr_ui_desc+"\n"
  #go through the frbr_relationships and construct nodes and edges for linked items
  @depth+=1
  
  
  for relationship in myObject.relationships
    
    #we should be able to just iterate over every class
  
    for venue in relationship.venues
      #print "found venue in : "+myObjectType+ " "+myObject.frbr_ui_desc+" "+venue.frbr_ui_desc+"\n"
      venueNodeId=newNode(venue.id,venue.frbr_ui_desc,venue.frbr_type,venue.frbr_ui_desc)
      newEdge(""+myObjectNodeDbId.to_s+"_"+myObjectType,venue.id.to_s+"_"+venue.frbr_type)
      @foundObjects[""+venue.id.to_s+"_"+venue.frbr_type]=venue
    end
  
    for event in relationship.events
      #print "found event in : "+myObjectType+ " "+myObject.frbr_ui_desc+" "+event.frbr_ui_desc+"\n"
      eventNodeId=newNode(event.id,event.frbr_ui_desc,event.frbr_type,event.frbr_ui_desc)
      newEdge(""+myObjectNodeDbId.to_s+"_"+myObjectType,event.id.to_s+"_"+event.frbr_type)
      @foundObjects[""+event.id.to_s+"_"+event.frbr_type]=event
    end
  
    for contributor in relationship.contributors
      #print "found contributor in : "+myObjectType+ " "+myObject.frbr_ui_desc+" "+contributor.frbr_ui_desc+"\n"
      contributorNodeId=newNode(contributor.id,contributor.frbr_ui_desc,contributor.frbr_type,contributor.frbr_ui_desc)
      newEdge(""+myObjectNodeDbId.to_s+"_"+myObjectType,contributor.id.to_s+"_"+contributor.frbr_type)
      @foundObjects[""+contributor.id.to_s+"_"+contributor.frbr_type]=contributor
    end
  
    for work in relationship.works
      #print "found work in : "+myObjectType+ " "+myObject.frbr_ui_desc+" "+work.frbr_ui_desc+"\n"
   
      workNodeId=newNode(work.id,work.frbr_ui_desc,work.frbr_type,work.frbr_ui_desc)
      newEdge(""+myObjectNodeDbId.to_s+"_"+myObjectType,work.id.to_s+"_"+work.frbr_type)
      @foundObjects[""+work.id.to_s+"_"+work.frbr_type]=work
    end
  
    for expression in relationship.expressions
      #print "found expression in : "+myObjectType+ " "+myObject.frbr_ui_desc+" "+expression.frbr_ui_desc+"\n"
      expressionNodeId=newNode(expression.id,expression.frbr_ui_desc,expression.frbr_type,expression.frbr_ui_desc)
      newEdge(""+myObjectNodeDbId.to_s+"_"+myObjectType,expression.id.to_s+"_"+expression.frbr_type)
      @foundObjects[""+expression.id.to_s+"_"+expression.frbr_type]=expression
    end
  
  end
  
  #if @depth < 5
    
    #remove self from found objects collection
    #foundObjects.delete(""+myObjectNodeDbId.to_s+"_"+myObjectType)
    #for foundObject in foundObjects.values
      #print "foundObject: "+foundObject.frbr_ui_desc+"\n"
      #frbr_relationships(foundObject,foundObject.id,foundObject.frbr_type)
    #end
  #end   
end

myWork=Work.find_by_solr('Arapatiki')[0]

#create a node for our work
workNodeId=newNode(myWork.id,myWork.frbr_ui_desc,myWork.frbr_type,myWork.frbr_ui_desc)
#create a node for our superwork
superworkNodeId=newNode(myWork.superwork.id,myWork.superwork.frbr_ui_desc,myWork.superwork.frbr_type,myWork.superwork.frbr_ui_desc)
#create an edge for this relationship
newEdge(""+myWork.id.to_s+"_"+myWork.frbr_type,""+myWork.superwork.id.to_s+"_"+myWork.superwork.frbr_type)

@depth=0;
@foundObjects.clear()
frbr_relationships(myWork,myWork.id,myWork.frbr_type)

@currentObjects=@foundObjects.clone
@foundObjects.clear()

for object in @currentObjects.values
frbr_relationships(object,object.id,object.frbr_type)
end



# now lets find all the expressions linked to our work
for expression in myWork.expressions
  expressionNodeId=newNode(expression.id,expression.frbr_ui_desc,expression.frbr_type,expression.frbr_ui_desc)
  newEdge(""+myWork.id.to_s+"_"+myWork.frbr_type,""+expression.id.to_s+"_"+expression.frbr_type)
  @depth=0;
  frbr_relationships(expression,expression.id,expression.frbr_type)
  #find the manifestations linked to the expression
  for manifestation in expression.manifestations
    manifestationNodeId=newNode(manifestation.id,manifestation.frbr_ui_desc,manifestation.frbr_type,manifestation.frbr_ui_desc)
    newEdge(""+expression.id.to_s+"_"+expression.frbr_type,manifestation.id.to_s+"_"+manifestation.frbr_type)
    @depth=0;
    frbr_relationships(manifestation,manifestationNodeId,manifestation.frbr_type)
    #find the samples linked to the manifestations
    for sample in manifestation.samples
      sampleNodeId=newNode(sample.id,sample.sample_description,'sample',sample.sample_description)
      newEdge(""+manifestation.id.to_s+"_"+manifestation.frbr_type,sample.id.to_s+"_"+'sample')
    end
  end
end



print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<graphml xmlns=\"http://graphml.graphdrawing.org/xmlns\">\n<graph edgedefault=\"undirected\">\n<key id='name' for='node' attr.name='name' attr.type='string'/>\n<key id='label' for='node' attr.name='label' attr.type='string'/>\n"

for node in @nodes.values
print "<node id='" + node['id'].to_s + "'><data key='name'>" + node['name'].to_s + "</data><data key='label'>" + node['label'].to_s + "("+node['type'].to_s+")</data></node>\n"
end

if @edges != nil
for edge in @edges.values
#print "edge: "+edge['source']+","+edge['target']+"\n";
if edge['source'] != nil and edge['target'] != nil
  
nodesourceHash=@nodes[edge['source']]
nodetargetHash=@nodes[edge['target']]
if nodesourceHash != nil and nodetargetHash != nil
print "<edge source='" + nodesourceHash['id'].to_s + "' target='" + nodetargetHash['id'].to_s + "'></edge>\n"  
end
end
end
end
print "</graph></graphml>\n"