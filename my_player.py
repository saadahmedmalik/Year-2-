from song import Song
from binary_search_tree import BinarySearchTree
from stack import Stack


class MyPlayer:
    def __init__(self):

        self.songList = [] #Empty List
        self.is_sorted = False #Initialized as a Boolean False
        self.yearMemory = {} #Empty Dictionary
        self.playHistory = Stack() #Initialized as a stack
        # TODO: Modify the above attribute for Task 6

    def loadLibrary(self, filename: str):

        filename = open(filename, 'r') #Open given file in 'read' name

        for line in filename:
            splitlines = line.strip().split('|') #Divide each line into segments along the '|' part to create separate variables

            new_song = Song(artist_name=splitlines[0], song_title=splitlines[1], song_id=splitlines[2],
                            duration=float(splitlines[3]), year=int(splitlines[4]))
            #Assign each variable as a specified trait for variable new_song for Song class
            self.songList.append(new_song) #Add the object new_song to list songList

    def quickSortHelper(self, songList, first, last): #Assisitive function 1 for QuickSort

        if first < last:
            splitpoint = self.partition(songList, first, last)

            self.quickSortHelper(songList, first, splitpoint - 1)
            self.quickSortHelper(songList, splitpoint + 1, last)

    def partition(self, songList, first, last): #Assistive function 2 for QuickSort

        pivotvalue = songList[first] #Assign pivotvalue to be object at given index (first index)

        leftmark = first + 1 #Assign number values to variable, will be useful as indexes
        rightmark = last #Assign number values to variable, will be useful as indexes

        done = False #Initializing the variable 'done'

        while not done: #Will execute the following code as long as 'done' remains False

            while leftmark <= rightmark and songList[leftmark].year <= pivotvalue.year: #When required year is ahead
                leftmark = leftmark + 1

            while songList[rightmark].year >= pivotvalue.year and rightmark >= leftmark: #When required year is behind
                rightmark = rightmark - 1

            if rightmark < leftmark: #Condition that will dictate whether or not an entire sweep has been made
                done = True
            else: #This interchanges the objects present at the left and rightmarks
                temp = songList[leftmark]
                songList[leftmark] = songList[rightmark]
                songList[rightmark] = temp

        temp = songList[first]
        songList[first] = songList[rightmark]
        songList[rightmark] = temp
        #This interchanges the pivot object with the object at the rightmark
        return rightmark

    def quickSort(self):

        self.quickSortHelper(self.songList, 0, len(self.songList) - 1) #Sorting songs within list according to year

        # TODO: Sort your songList here...
        self.is_sorted = True

    def playSong(self, title: str):

        songs = self.songList #Converting variable 'songs' into list songList

        for items in songs:
            if items.song_title == title: #Condition checking if the title of item matches the input title
                self.playHistory.push(items) #Adds item to the end of the array
                items.play() #Returns string describing the song

    def getLastPlayed(self):
        if not self.playHistory.isEmpty(): #Checking if stack is empty, if not command goes forward
            return self.playHistory.peek() #Returns item on top of stack
        else:
            return None #If stack is indeed empty, return None

    def hashfunction(self, song): #A Hash Function which returns the 'year' of input song
        return song.year

    def buildYearMemory(self):

        for song in self.songList: #Individually for each item in list

            year = self.hashfunction(song) #Creating variable 'year' to become a year value using separately created hashfunction

            if year not in self.yearMemory: #If 'year' already not within stored record
                self.yearMemory[year] = BinarySearchTree() #Item present at given index is made into a Binary Search Tree
                                                           #from which further division can be done
            self.yearMemory[year].put(song.song_title, song) #Using key, value pairs to place items into the BST using
                                                             #song titles as keys, and actual songs as values

    def getYearMemory(self, year, title, currentnode=None, steps=0):

        if year in self.yearMemory:
            # Number of steps used to search for the song
            the_song = None  # The song
            if currentnode == None:
                    currentnode = self.yearMemory[year].root #Initialize currentnode as top index value in BST
            while not the_song and currentnode is not None: #Condition for which code will run if True

                    if title == currentnode.key: #If input title is the same as the key of the node, i.e. titles match
                        steps += 1 #Add step
                        the_song = currentnode.payload #the_song is the value at that current node
                        return {"steps": steps, "song": the_song}
                    if currentnode is not None:
                        steps += 1 #Add step
                        if title < currentnode.key: #For when song is to the left of current node
                            if self.getYearMemory(year, title, currentnode.leftChild, steps) is not None:

                                return self.getYearMemory(year, title, currentnode.leftChild, steps) #Change current node to left child
                            else:
                                return {"song": None, "steps": steps}
                        elif title > currentnode.key: #For when song is to the right of current node
                            if self.getYearMemory(year, title, currentnode.rightChild, steps) is not None:
                                return self.getYearMemory(year, title, currentnode.rightChild, steps)
                            else:
                                return {"song": None, "steps": steps}
                    else:
                        return {"song": None, "steps": steps}
        else:
            return {"song": None, "steps": steps} #Returns None if year is not present within memory
    def getSong(self, year, title):

        count = 0 #Initialize count to be equal to zero
        for item in self.songList:
            if item.song_title == title: #If titles match, the following code will execute
                the_song = item #Assign variable the_song to be the actual song object we're looking to get
                return {"song": item, "steps": count+1}
            else:
                count += 1

        steps = 0  # Number of steps used to search for the song
        the_song = None  # The song

        # TODO: Search for the song, Note, you are NOT allowed to use self.yearMemory in this method

        # Do not modify the return line, assign proper values for
        # steps and song above
        return {"steps": steps, "song": the_song}

# NO MORE TESTING CODE BELOW!
# TO TEST YOUR CODE, MODIFY test_my_player.py
