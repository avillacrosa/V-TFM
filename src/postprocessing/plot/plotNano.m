function plotNano(Geo, Mat, Result)
	plot(Result.uz, Result.Tz)
	xlabel("Indentation (nm)");
	ylabel("Load (N)")
	title("Nanoindentation")
end