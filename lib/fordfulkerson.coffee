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

    if directed
      # residual = capacity - flow
      Edges[source][sink] = {capacity, flow:0}
      Edges[sink][source] = {capacity:0, flow:0}
    else
      # the residual capacity is the same for undirected
      Edges[source][sink] = {capacity, flow:0}
      Edges[sink][source] = {capacity, flow:0}

  findPath = (source, sink, path=[]) ->
    # recursively find path
    if source is sink then return path

    # get the edges from the source
    edges =  _.values Edges[source]
    # remove the edges that are in the path
    edges = _.difference edges, path

    for edge in edges
      potentialFlow = edge.capacity - edge.flow
      if potentialFlow > 0
        potentialPath = _.clone(path).push(edge)
        maybePath = findPath(edge.sink, sink, potentialPath)
        if maybePath return maybePath

    return null

  computeFlow = (source, sink) ->
    path = findPath(source, sink)
    if path
      bottleneckFlow = _(path).values('capacity').min()
      
      updateFlow = (edge) ->
        # forward gets flow, but less capacity
        edge.flow += bottleneckFlow
        edge.capacity -= bottleneckFlow
        # reverse gets less flow but more capacity
        reverse = reverseEdge(edge)
        reverse.capacity += bottleneckFlow
        reverse.flow -= bottleneckFlow

      path.map updateFlow
      return flowStep(source, sink)
    
    maxFlow = _.values(Edges[source], 'flow').sum()
    minCut = maxFlow
    return {Edges, maxFlow, minCut}

  return {addEdge, findPath, computeFlow, load, save}