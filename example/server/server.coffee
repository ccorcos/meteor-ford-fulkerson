@Graph = FordFulkerson()
Graph.addEdge 0, 1, 16
Graph.addEdge 0, 2, 13
Graph.addEdge 1, 2, 10
Graph.addEdge 2, 1, 4
Graph.addEdge 1, 3, 12
Graph.addEdge 3, 2, 9
Graph.addEdge 2, 4, 14
Graph.addEdge 4, 3, 7
Graph.addEdge 3, 5, 20
Graph.addEdge 4, 5, 4
@result = Graph.computeFlow(0, 5)
maxFlow = result.maxFlow

if maxFlow is 23
  console.log 'success 1'
else
  console.log 'failure 2'


@Graph = FordFulkerson()
Graph.addEdge 1, 2, 10
Graph.addEdge 1, 3, 5
Graph.addEdge 2, 3, 4
Graph.addEdge 1, 4, 15
Graph.addEdge 3, 4, 4
Graph.addEdge 2, 5, 9
Graph.addEdge 2, 6, 15
Graph.addEdge 5, 6, 15
Graph.addEdge 3, 6, 8
Graph.addEdge 7, 3, 6
Graph.addEdge 4, 7, 16
Graph.addEdge 5, 8, 10
Graph.addEdge 6, 8, 10
Graph.addEdge 7, 8, 10

@result = Graph.computeFlow(1, 8)
maxFlow = result.maxFlow

if maxFlow is 28
  console.log 'success 2'
else
  console.log 'failure 2'