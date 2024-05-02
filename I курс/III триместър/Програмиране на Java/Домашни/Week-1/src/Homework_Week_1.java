public class Homework_Week_1 {

    public static void main  (String[] args)
    {

        String facultyNumber = "2001261067";
        String personName = "Tony Miroslavov";

        short metalSwords = 15;
        short aluminumBumpers = 10;
        byte gasPistol = 1;
        byte woodenTank = 1;
        byte plasticBarrel= 1;
        float leatherBag = 169.77f;

        String [] serialNumbers = {
                "S-6", "B-7", "P-6", "T-4", "B-6", "B-3"
        };

        String [] qualitiesOfObjects = {
                "Metal", "Aluminum", "Gas", "Wooden", "Plastic", "Leather"
        };
        String [] namesOfObjects = {
                "Swords", "Bumpers", "Pistol", "Tank", "Barrel", "Bag"
        };

        boolean doYouWantToGraduate = true;

        System.out.println(facultyNumber);
        System.out.println(personName);
        System.out.println(java.util.Arrays.toString(serialNumbers));
        System.out.println(java.util.Arrays.toString(qualitiesOfObjects));
        System.out.println(java.util.Arrays.toString(namesOfObjects));



    }
}

