# Ford Fulkerson Algorithm

An implementation of the Fork Fulkerson algorithm.

## Getting Started

    meteor add ccorcos:ford-fulkerson

## API

You should just looks at the source code.

1. Initialize a graph.

        Graph = FordFulkerson()

2. Add edges with `Graph.added source, sink, capacity, [directed=true]`
    
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

3. Compute the flow of the graph for source to sink.

        result = Graph.computeFlow(0, 5)
        result.minCut # > 23
        result.maxFlow # > 23
        savedGraph = result.Edges # Save this for later. or user Graph.save

        # later
        Graph2 = FordFulkerson()
        Graph2.load savedGraph

## To Do

- [Add or remove node without recomputing the whole thing](http://cstheory.stackexchange.com/questions/9938/incremental-maximum-flow-in-dynamic-graphs).
- Change edge capacity without recomputing the whole thing.
  - add capacity, recompute
  - remove capacity
    - if still more than flow, then nothing
    - if less that flow, then reduce forward all flow by 1.
- Use a collection for the graph, personalized to each user? This is going to get huge.
