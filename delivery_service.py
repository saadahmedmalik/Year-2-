"""
UMass ECE 241 - Advanced Programming
Project 2 - Fall 2023
"""
import sys
from graph import Graph, Vertex
from priority_queue import PriorityQueue
from bellmanford import BellmanFord
from prims import prim
from DIk import dijkstra

class DeliveryService:
    def __init__(self) -> None:
        self.city_map = Graph() # Initialize self.city_map as a Graph
        self.MST = None # Initialize self.MST as None

    def buildMap(self, filename: str) -> None:

        file = open(filename, 'r') # Opens a file in read mode, to be manipulated as required ahead

        for line in file:
            splitpoint = line.strip().split('|') # Splits characters in the line at the '|' point in the string

            nodeA = int(splitpoint[0]) # Assign value at Index 0
            nodeB = int(splitpoint[1]) # Assign value at Index 1
            Nodecost = int(splitpoint[2]) # Assign value at Index 2

            self.city_map.addEdge(nodeA, nodeB, Nodecost) # Add aforementioned characteristics to self.city_map as values and node cost


    def isWithinServiceRange(self, restaurant: int, user: int, threshold: int) -> bool:
        if restaurant in self.city_map.getVertices() and user in self.city_map.getVertices(): # Check if restaurant and user are valid vertices in the map, proceed ony then
            return BellmanFord(self.city_map, restaurant, user, threshold) # Use Bellman Ford algorithm to check and provide an indication on whether the distance is in a specified range
        else: return False # If none of the above is applicable, return a False



    def buildMST(self, restaurant: int) -> bool:

        self.MST = prim(self.city_map, self.city_map.getVertex(restaurant)) # Use Prim's algorithm to construct a Minimum Spanning Tree



    def minimalDeliveryTime(self, restaurant: int, user: int) -> int:

        if restaurant in self.MST.getVertices() and user in self.MST.getVertices(): # Check if both restaurant and user, are valid vertices in the MST, proceed only then
            return BellmanFord(self.MST, restaurant, user, None) # Use Bellman Ford Algorithm to calculate the minimum delivery time
        else:
            return -1 # Return -1 if either restaurant or user are not valid vertices in the MST

    def findDeliveryPath(self, restaurant: int, user: int) -> str:

        if restaurant in self.city_map.getVertices() and user in self.city_map.getVertices(): # Check if restaurant and user are valid vertices in self.city_map, proceed only then
            return dijkstra(self.city_map,self.city_map.getVertex(restaurant),self.city_map.getVertex(user), None) # Use Dijkstra's algorithm to find the shortest delivery path
        else:
            return "INVALID" # Return Invalid if either restaurant or user are not valid vertices in self.city_map
    def findDeliveryPathWithDelay(self, restaurant: int, user: int, delay_info: dict[int, int]) -> str:

        if restaurant in self.city_map.getVertices() and user in self.city_map.getVertices(): # Check if restaurant and user are valid vertices in self.city_map, proceed only then
            return dijkstra(self.city_map,self.city_map.getVertex(restaurant),self.city_map.getVertex(user), delay_info) # Use Dijkstra's algorithm to find delivery path with mecessary delay information
        else:
            return "INVALID" # Return Invalid if either restaurant or user are not valid vertices in self.city_map


    ## DO NOT MODIFY CODE BELOW!
    @staticmethod
    def nodeEdgeWeight(v):
        return sum([w for w in v.connectedTo.values()])

    @staticmethod
    def totalEdgeWeight(g):
        return sum([DeliveryService.nodeEdgeWeight(v) for v in g]) // 2

    @staticmethod
    def checkMST(g):
        for v in g:
            v.color = 'white'

        for v in g:
            if v.color == 'white' and not DeliveryService.DFS(g, v):
                return 'Your MST contains circles'
        return 'MST'

    @staticmethod
    def DFS(g, v):
        v.color = 'gray'
        for nextVertex in v.getConnections():
            if nextVertex.color == 'white':
                if not DeliveryService.DFS(g, nextVertex):
                    return False
            elif nextVertex.color == 'black':
                return False
        v.color = 'black'

        return True

# NO MORE TESTING CODE BELOW!
# TO TEST YOUR CODE, MODIFY test_delivery_service.py
