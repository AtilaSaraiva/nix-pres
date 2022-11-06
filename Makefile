pres.pdf: notes.md
	pandoc $< -t beamer --slide-level 2 -o $@

clean:
	rm pres.pdf
