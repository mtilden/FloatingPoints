pragma ada_2012;
with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;
WITH Unchecked_Conversion;


PROCEDURE Floating IS

   procedure scisolve (f: in out float; floatin: out float;
   							bin_f: in out unsigned32; neg_num: out boolean) is
	   floatin,temp: Float;
	   negnum: boolean;
	   exp_counter: Integer := 0;
	   bin_sign,bin_exp, bin_bitsm, exp: Integer;
	   type unsigned32 is mod 2**32;
	   package unsigned32_io is new ada.text_io.modular_io(unsigned32);
         FUNCTION Convert IS NEW Unchecked_Conversion(Source => Float, Target => Unsigned32);
         Bin_F: Unsigned32 := Convert(F);



	   subtype Bit is Integer range 0 .. 1;
	   type BitString is array(1 .. 32) of Bit
		   with component_size => 1,			-- One bit per array element
		   size => 32;			-- 32 bits for the entire array

		bits: BitString;  --- neeed to create copy bits

   begin
      Exp:=127;
      temp := abs floatin;
	   put("As entered:                           ");
	   if floatin < 0.0 then 	--checks if floatin is a positive or negative number
		   negnum := true;
		   floatin := abs floatin;
		   put("-");
		   put(floatin, fore => 1, aft => 23, exp => 0);  			-- negative
		   new_line;
		   put("Decimal scientific notation:           ");
		   put("-"); -- puts neg at beginning
		   put(floatin, fore => 1, aft => 10, exp => 10);  -- puts floatin in dec sci
		   new_line;                                          --notation
		   put("Binary scientific notation:           ");  --prints this then "-"
		   put("-");
		   put(bin_f, base => 2, width => 35);       -- prints bin_f : unsigned32 in base2
		   put(convert(bin_f), base => 2, width => 35);
		   new_line;
	   elsif floatin > 0.0   				 	--positive
		   negnum := false;  -- means the number is positive
		   put(" ");
		   put(floatin, fore => 1, aft => 23, exp => 0);
		   new_line;
		   put("Decimal scientific notation:           ");
		   put(floatin, fore => 1, aft => 10, exp => 10);
		   new_line;
		   put("Binary scientific notation:            ");
		   put(bin_f, base => 2, width => 35);
		   put(convert(bin_f), base => 2, width => 35);
		   new_line;


      ELSE          -- else if f is 0.0
         Put("As entered:                             0.00000000000000000000000");
         new_line;
         Put("Decimal scientific notation:            0.0000000000E-00"); New_Line
         Put("Binary scientific notation:             0.0000 0000 0000 0000 0000 000 * 2**0");
         new_line;
         put("Calculated FP representation: 0 0000 0000 0000 0000 0000 0000 0000 000"); new_line;
         Put("Conversion to bit array:      ");
         FOR z in 1 .. 32 LOOP
            Bits(Z) := 0;
            Put(Bits(Z));
         end loop;
         New_Line;
         ----------------------
         put("Put to string in FP rep.:     2 #000 0000 0000 0000 0000 0000 0000 000#"); new_line;
         put("Put in FP representation:    2#000000000000000000000000000000#"); new_line;

	   end if; 					--end if for as entered
	   -------------------------------

	 	  put("Calculated FP representation: ");
      IF Neg_Num = True THEN
               Bin_Sign := 1;

      ELSE
               bin_sign := 0;

      END IF;
      bits(1) := bin_sign;   -- stores sign in first element of array

      IF Temp >= 2.0 THEN --if the float is greater than or = to 2.0
         WHILE Temp >= 2.0 LOOP
            Temp := Temp / 2;
            Exp := Exp + 1;
         END LOOP;
      ELSif Temp < 1.0 THEN   -- if temp is less then one temp = temp *2
         WHILE Temp< 1.0 LOOP
            Temp := Temp * 2.0;
            Exp := Exp - 1;             -- and subtract exp counter
         END LOOP;
      ELSE          -- else temp is in between 1.0 .. 1.999999
         end if;

      -----------------------------
      -- turn binary into an array
      FOR E IN 1 .. 8 LOOP   -- to get exp in binary

       if exp mod 2 := 0 then
            Bits(9 - E) := 0;
       ELSE
            Bits(9 - E) := 1;
       end if;
      END LOOP;   -- puts elements backwars in spots 2 .. 9 of bits array


      temp := temp - 1;   --Get rid of the 1, it is hidden, now keep between 0 <= temp < 1

      FOR F IN 1 .. 23 LOOP               -- for loop to get binary of number last 23 nums in arrau
         Temp := Temp * 2;               -- multi by 2

         IF Temp  >= 1 THEN            -- if the float is greater than 1
            Temp = Temp - 1;            -- subtract one and put a 1 in the array
            Bits (F + 9) := 1;
         ELSE
            Bits(F + 9) := 0;            -- if less than one put a zero
         END IF;                         -- end if
      END LOOP;             -- end for loop

      --------------------------------------
      put("Calculated FP representation: ");
      FOR A IN 1 .. 32 LOOP         -- for loop to print out each bit of array
         Put(Bits(A));
      END LOOP;               -- end loop

      New_Line;
      ----------------------
      Put("Put to string in FP rep.:     ");

      -------------------
      -- put in string rep
      New_Line;
      --------------------
      Put("Put in FP representation:    ");
      -- put in fp red
      new_line;
         END Scisolve;

   F, temp_f: Float;

BEGIN
   WHILE NOT End_Of_File LOOP

     get(f);         -- get float each time
	 temp_f := f;         -- save f
     scisolve(f);         -- procedure to get info for f
  end loop;

end floating;
