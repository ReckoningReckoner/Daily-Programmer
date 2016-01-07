def read_data(filename):
   data = []
   for num in open(filename).read().split(","):
      num = num.strip()
      if num[0] == "(":
         data.append([int(num[1:])])
      elif num[-1] == ")":
         data[-1].append(int(num[:-1]))
         data[-1] = tuple(data[-1])
      else:
         data[-1].append(int(num))
         
   return data
   
def get_node_values(data):
   node_values = []
   
   for n1, n2, zombies in data:
      if n1 not in node_values:
         node_values.append(n1)
      elif n2 not in node_values:
         node_values.append(n2)
         
   return node_values
   
def create_nodes(node_values, data):
   city_map = {}
   for node in node_values: 
      city_map[node] = {'name': node, 'neighbours': [], 'dist': float("inf")}
      
   for  n1, n2, zombie in data:
      city_map[n1]['neighbours'].append({'node': city_map[n2], 'zombie': zombie})
      city_map[n2]['neighbours'].append({'node': city_map[n1], 'zombie': zombie})
   
   return city_map #starting node
   
   
def shortest(city_map, source):
   unvisited = []
   visited = {}
   path = []

      
   for i in range(len(city_map)):
      unvisited.append(city_map[i])
   
   source['dist'] = 0
   
   while len(unvisited) > 0:
      min_distance = float("inf")
      current = None
      
      for i in range(len(city_map)):
         dist = city_map[i]['dist']
         if dist != None and dist <= min_distance:
            current = city_map[i]
            min_distance = dist
            
      unvisited.remove(current)
      
      min_distance = float("inf")
      for n in current['neighbours']:
         alt = current['dist'] + n['zombie']
         if alt < n['node']['dist']:
            n['dist'] = alt
            visited[n['node']['name']] = current['name']
      
      return visited
            

def parse(filename):
   data = read_data(filename)
   node_values = get_node_values(data)
   
   city_map = create_nodes(node_values, data)
   
   v = shortest(city_map, city_map[0])
   for k in v:
      print(v)
   

parse("1.txt")