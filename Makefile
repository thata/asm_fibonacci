fibonacci: fibonacci.S
	gcc fibonacci.S -o fibonacci

clean:
	rm -rf fibonacci

run:
	./fibonacci
