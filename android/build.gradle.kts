allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Define custom root build directory (optional, usually not needed)
val newBuildDir = File(rootProject.projectDir, "../build")

subprojects {
    // Set custom build directory for subprojects
    buildDir = File(newBuildDir, name)

    // Ensure evaluation order
    evaluationDependsOn(":app")
}

// Define clean task
tasks.register<Delete>("clean") {
    delete(newBuildDir)
}
