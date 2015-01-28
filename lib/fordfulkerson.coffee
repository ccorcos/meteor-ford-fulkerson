FordFulkerson = ->

  Edges = {}

  load = (E) -> Edges = E
  save = () -> Edges
  
  reverseEdge = (edge) -> Edges[edge.sink][edge.source]
  
  addEdge = (source, sink, capacity, directed=true) ->
    unless Edges[source]
      Edges[source] = {}
    unless Edges[sink]
      Edges[sink] = {}

    # the capcity the "residual" capacity: how much more that edge can flow
    # the flow is how much that edge is already flowing.
    # increases flow and decreases the capacity of the edge but
    # decreases flow and increases the capacity of the reverse edge
    if directed
      Edges[source][sink] = {source, sink, capacity, flow:0}
      Edges[sink][source] = {sink:source, source:sink, capacity:0, flow:0}
    else
      Edges[source][sink] = {source, sink, capacity, flow:0}
      Edges[sink][source] = {sink:source, source:sink, capacity, flow:0}

  findPath = (source, sink, path=[]) ->
    # recursively find path
    if source is sink then return path

    # get the edges from the source
    edges =  _.values Edges[source]
    # remove the edges that are in the path
    edges = _.difference edges, path

    for edge in edges
      if edge.capacity > 0
        potentialPath = _.clone(path)
        potentialPath.push(edge)
        maybePath = findPath(edge.sink, sink, potentialPath)
        if maybePath then return maybePath

    # no more path for flow
    return null

  computeFlow = (source, sink) ->
    path = findPath(source, sink)
    if path
      # console.log "PATH", path
      bottleneckFlow = _.pluck(path, 'capacity').min()
      # console.log "BOTTLENECK", bottleneckFlow
      
      updateFlow = (edge) ->
        reverse = reverseEdge(edge)
        # console.log "FORWARD: #{edge.flow}/#{edge.capacity} -> #{edge.flow+bottleneckFlow}/#{edge.capacity-bottleneckFlow}"
        # console.log "REVERSE: #{reverse.flow}/#{reverse.capacity} -> #{reverse.flow-bottleneckFlow}/#{reverse.capacity+bottleneckFlow}"
        # forward gets flow, but less capacity
        edge.flow += bottleneckFlow
        edge.capacity -= bottleneckFlow
        # reverse gets less flow but more capacity
        reverse.capacity += bottleneckFlow
        reverse.flow -= bottleneckFlow

      path.map updateFlow
      return computeFlow(source, sink)
    
    maxFlow = _.pluck(Edges[source], 'flow').sum()
    minCut = maxFlow
    return {Edges, maxFlow, minCut}

  return {addEdge, findPath, computeFlow, load, save}