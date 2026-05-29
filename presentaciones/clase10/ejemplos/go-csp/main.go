package main

import (
	"fmt"
	"math/rand"
)

func worker(e <-chan int, r chan<- int) {
	suma := 0
	for n := range e {
		suma += n
	}
	r <- suma
}

func main() {
	entrada := make(chan int)
	resultados := make(chan int)

	go func() {
		for range 10000 {
			entrada <- rand.Intn(100)
		}
		close(entrada)
	}()

	for range 100 {
		go worker(entrada, resultados)
	}

	total := 0
	for range 100 {
		parcial := <-resultados
		total += parcial
	}
	fmt.Println(total)
}
