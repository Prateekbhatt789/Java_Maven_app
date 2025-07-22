package com.example;
import java.util.Random;
import java.util.Scanner;

public class Main
{
	public static void main(String[] args) {
		System.out.println("word checker");
		String[] sampleText = {"In a bustling city, a cozy café offered refuge from chaos. The aroma of coffee filled the air as patrons shared stories and laughter. ",
		"In a quaint village, Elara loved exploring the forest. One day, she found a shimmering pond with a talking golden fish. ",
		"As the sun set, the sky glowed golden, and stars appeared. A gentle breeze rustled leaves while fireflies danced in the field.",
		"A group of friends decided to escape technology and go camping. They hiked through a lush forest, marveling at nature's beauty.",
		"A hidden community garden thrived in the urban landscape. Filled with colorful flowers and fresh vegetables, it became a gathering place for neighbors"};
		Random random = new Random();
		int randomInt = random.nextInt(5); 
        System.out.println("Type Text: " + sampleText[randomInt]);
        System.out.println("Countdown starts");
        for (int i=3; i>0;i--){
            System.out.println(i);
            try{
                Thread.sleep(1000);
            }
            catch (InterruptedException e){
                System.out.println("Error occur in countdown:" + e);
            }
        }
        System.out.println("Start Typing");
        long startTime = System.nanoTime();
        Scanner scanner = new Scanner(System.in);
        String userText = scanner.nextLine();
        long endTime = System.nanoTime();
        double typingTime = (double)(endTime - startTime) / 1_000_000_000.0;
        int numChars = userText.length();
        int wpm = (int)((((double)numChars/5)/typingTime) * 60);
        System.out.println("wpm: " + wpm);
	}
}