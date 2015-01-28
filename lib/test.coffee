Tinytest.add 'Test on a graph', (test) ->
  # Using this example graph:
  # http://www.geeksforgeeks.org/ford-fulkerson-algorithm-for-maximum-flow-problem/
  Graph = FordFulkerson()
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
  maxFlow = Graph.computeFlow(0, 6).maxFlow

  test.isTrue(maxFlow is 23, 'FordFulkerson is not working...');
