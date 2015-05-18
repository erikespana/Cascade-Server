LOGIC:

1. A data definition block contains a certain number set of stories, in the order of appearence.

2. A certain number of days of the month corresponds to each of these sets.
Example: If this is taken to be 3 days, every 3 days corresponds to 1 set of 
stories.
So every 3 days, we have a new set of stories.(So we can refer to this as the
Refresh Interval.)

3. The challenge is to keep track of which set we're currently on and which set 
we need to move to next.

4. This can be calculated using a simple algorithm: 
Day - (Day % RefreshInterval)
Eg: setNumber = 10 - (10 % 3)

This gives the set of stories corresponding to the Day.

5. Each set can have any number of stories (given the block does not run out 
of stories)
If n is the number of stories, then the index of each story would be:
i = setNumber + l, where l = 0 - n
We iterate through the array of stories obtained from block to get these sets.

-+-+-+-+- IMPORTANT NOTE -+-+-+-+-

For this to work fine, there must be at the least

(numberOfStories * refreshInterval)

number of stories in the block.

-+-+-+-+--+-+-+-+--+-+-+-+--+-+-+-

More applications of the Modulus Operator: http://stackoverflow.com/questions/2609315/recognizing-when-to-use-the-modulus-operator]
