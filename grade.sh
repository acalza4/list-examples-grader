CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point
if [ -f "student-submission/ListExamples.java" ]; then
    echo "File found"
else
    echo "File not found"
    exit 1
fi

# Then, add here code to compile and run, and do any post-processing of the
# tests
cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java

if [ $? -ne 0 ]; then
    echo "Compilation error"
    exit 1
fi

echo "Program compiled successfully!"

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt

grep "OK" output.txt > grepoutput.txt

if [ $? -ne 0 ]; then
    echo "You suck try again; score 0%"
    exit 1
else
    echo "you rock score: 100%"
fi