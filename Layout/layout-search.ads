-- the spec for layout-search
-- 810:174:01 Spring '11
-- group name: Cleveland Express
-- managed by: Andrew Schutt

package Layout.Search is

   -- This child package provides types and a procedure to determine the
   -- blocks and the turnouts beneath a train given the location of its
   -- locomotive and caboose.


   -----------------------------------------------------------------------------
   -- Types for a list of blocks
   -----------------------------------------------------------------------------

   type Block_Rec is   -- Elements in the list of blocks
      record
         Block     : Block_Number;
         Direction : Polarity;
      end record;
   type Block_Array is array (Positive range <>) of Block_Rec;

   -- The value of the record discriminant Max_Size determines the maximum
   -- number of blocks in the list.  This discriminant is set when a variable
   -- of type Block_List is declared

   type Block_List (Max_Size : Positive) is
      record
         Size : Natural := 0;
         Items : Block_Array (1 .. Max_Size);
      end record;

   -----------------------------------------------------------------------------
   -- Types for a list of turnouts
   -----------------------------------------------------------------------------

   type Turnout_Rec is   -- Elements in the list of turnouts
      record
         Turnout   : Turnout_Num;
         Direction : Limb;
      end record;
   type Turnout_Array is array (Positive range <>) of Turnout_Rec;

   -- The value of the record discriminant Max_Size determines the maximum
   -- number of turnouts in the list.  This discriminant is set when a variable
   -- of type Turnout_List is declared

   type Turnout_List (Max_Size : Positive) is
      record
         Size : Natural := 0;
         Items : Turnout_Array (1 .. Max_Size);
      end record;



   -----------------------------------------------------------------------------
   procedure Blocks_Beneath (Loco     : in  Block_Number;     -- Front of train
                             Caboose  : in  Block_Number;     -- Rear of train
                             Blocks   : out Block_List;       -- Under train
                             Turnouts : out Turnout_List;     -- Under train
                             Success  : out Boolean);

   -- Search the layout for the blocks and turnouts beneath a train
   --
   -- Preconditions  : Loco /= Caboose
   --
   -- Postconditions : If Success then
   --                     Blocks is a list of blocks under the train and the
   --                        direction each block should be powered to move
   --                        the train in the forward direction.
   --                        The blocks in this list are in order from
   --                        Caboose to Loco.
   --                     Turnouts is a list of turnouts under the train and
   --                        the direction each turnout should be set.
   --                        The turnouts in this list are in no order.
   --                  Else
   --                      We were unable to locate the train.  Based on the
   --                      input, there are more blocks or turnouts under the
   --                      train than will fit on the lists.
   --                      Blocks and Turnouts are undefined.

end Layout.Search;
