#!groovy
def imageName = 'drunken-octopus-build-image';
def majorVersion = 0;
def minorVersion = 0;
def repositories = [
        ['credential': 'docker_hub', 'registry': 'https://index.docker.io', 'repository': 'drunkenoctopus']
]

if (null == imageName) {
    error("imageName must be set.")
}
if (null == majorVersion) {
    error("majorVersion must be set.")
}
if (null == minorVersion) {
    error("minorVersion must be set.")
}
if (null == repositories) {
    error("repositories must be set.")
}

def scmResult

node() {
    stage('checkout') {
        deleteDir()
        scmResult = checkout(scm)
    }
    def repositoryName = scmResult.GIT_URL.replaceAll('^.+:(.+)\\.git$', '$1')
    def versions = []

    if (env.BRANCH_NAME == 'master') {
        versions.add("latest")
        versions.add("${majorVersion}.${minorVersion}.${env.BUILD_NUMBER}")
    } else {
        versions.add("${env.BRANCH_NAME}-${env.BUILD_NUMBER}")
    }


    stage('build') {
        repositories.each { repository ->
            def repositoryUrl = repository['registry']
            def uri = new java.net.URI(repositoryUrl);
            //['credential': 'custenborder_docker', 'registry': 'https://docker.custenborder.com', 'repository': 'jcustenborder']
            withDockerRegistry(url: "", credentialsId: repository['credential']) {
                versions.each { version ->
                    def image = docker.build("${repository['repository']}/${imageName}:${version}")
                    image.push()
                }
            }
        }

        //TODO: Come back and add support for releases
//        if (env.BRANCH_NAME == 'master') {
//            def changelogGenerator = new ReleaseNoteGenerator(scmResult, steps)
//            def changelog = changelogGenerator.generate()
//            def version = "${majorVersion}.${minorVersion}.${env.BUILD_NUMBER}"
//            writeFile file: "RELEASENOTES.md", text: changelog
//            withCredentials([string(credentialsId: 'github_api_token', variable: 'apiToken')]) {
//                githubRelease(
//                        commitish: scmResult.GIT_COMMIT,
//                        token: apiToken,
//                        description: "${changelog}",
//                        repositoryName: repositoryName,
//                        tagName: version,
//                        includes: "RELEASENOTES.md"
//                )
//            }
//        }

    }
}