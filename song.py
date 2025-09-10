class Song:
    def __init__(self, artist_name, song_title, song_id, duration, year):

        self.artist_name = artist_name
        self.song_title = song_title
        self.song_id = song_id
        self.duration = float(duration) #Initialzing duration as a float number from input
        self.year = year




    def __str__(self):

        return str(self.song_title)+" by "+str(self.artist_name)+" (ID: "+str(self.song_id)+") released in "+str(self.year)
        #Returning a string as output and ensuring all variable inputs are converted from their type to string

    def play(self):

        print(str(self.song_title)+" is playing, with a duration of "+str('{:.6f}'.format(self.duration))+" second(s)")
        #Returning a string as output and ensuring all variable inputs are converted from their type to string, with
        #an addition of an extra command to ensure self.duration is returned to 6 decimal points.


