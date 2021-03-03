package main

import (
	"context"
	"fmt"
	"time"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
)

func main() {
	// creates the in-cluster config
	config, err := rest.InClusterConfig()
	if err != nil {
		panic(err.Error())
	}

	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	for {
		configMap, err := clientset.CoreV1().ConfigMaps("default").Get(context.TODO(), "poots", metav1.GetOptions{})
		if err != nil {
			fmt.Printf("Error getting configMap %v\n", err.Error())
		} else {
			fmt.Printf("ConfigMap: %s\n", configMap.Data["player_initial_lives"])
		}

		time.Sleep(2 * time.Second)
	}
}
