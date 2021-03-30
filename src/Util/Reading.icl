implementation module Util.Reading

import StdEnv, StdIO

instance == RGBColour
where
	(==) x y = x.r == y.r && x.b == y.b && x.g == y.g
	(==) _ _ = False

getPixels :: *File -> ([RGBColour], *File)
getPixels file
 	#(isEnd, file) = fend file
  	|isEnd = ([], file)
	# (b1,r1 ,file) = freadi file
	# (b2,r2 ,file) = freadi file
	# (b3,r3 ,file) = freadi file
	| not(b1 && b2 && b3) = ([], file) 
  	#rec = {r = r1, g = r2, b=r3}
  	#(res,file) = getPixels file
 	=([rec:res],file)

readPicture :: *File -> (PiecePicture,*File)
readPicture file
	#! (b1, x, file) = freadi file
	#! (b2, y, file) = freadi file
	#! (pixels, file) = getPixels file 
	| b1 && b2 = ({tileWidth = x,tileHeight = y,arrayOfPixels = pixels}, file)
	| otherwise = abort "Reading Error 1 !"

LoadPicture :: String *World ->  (PiecePicture,*World)
LoadPicture fname w
	#! (ok, file, w) = fopen fname FReadText w
	| not ok = abort "Can't open"
	#! (content, file) = readPicture file
	//# (ok, w) = fclose file w
	//| not ok = abort "Can't close"
	= (content, w)

