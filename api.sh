GITHUB_API_URL=\${GITHUB_API_URL:-'https://api.github.com'}
                      |BLOCK_API_URL="\${GITHUB_API_URL}/repos/\${SERVICE_NAME}/git/tags"
                      |
                      |POST_DOC="{\\"tag\\":\\"\${TAG}\\",\\"message\\":\\"\${MESSAGE}\\",\\"object\\":\\"\${COMMIT_ID}\\",\\"type\\":\\"commit\\"}"
                      |
                      |# Add a tag object
                      |RESP_CODE=\$(curl -sS -L -d "\${POST_DOC}" -X POST "\${BLOCK_API_URL}?access_token=\${GITHUB_OAUTH_TOKEN}" -o /dev/null -w "%{http_code}")
                      |if [[ "x\${RESP_CODE}" != "x201" ]]; then
                      |  echo "Request: curl -sS -L -d \\"\${POST_DOC}\\" -X POST \\"\${BLOCK_API_URL}?access_token=\${GITHUB_OAUTH_TOKEN}\\""
                      |  echo "Response code: \${RESP_CODE}"
                      |  echo "Expected response code: 201"
                      |  exit 1
                      |fi
                      |
                      |# Add a tag reference
                      |BLOCK_API_URL="\${GITHUB_API_URL}/repos/\${SERVICE_NAME}/git/refs"
                      |POST_DOC="{\\"ref\\":\\"refs/tags/\${TAG}\\",\\"sha\\":\\"\${COMMIT_ID}\\"}"
                      |RESP_CODE=\$(curl -sS -L -d "\${POST_DOC}" -X POST "\${BLOCK_API_URL}?access_token=\${GITHUB_OAUTH_TOKEN}" -o /dev/null -w "%{http_code}")
                      |if [[ "x\${RESP_CODE}" != "x201" ]]; then
                      |  echo "Request: curl -sS -L -d \\"\${POST_DOC}\\" -X POST \\"\${BLOCK_API_URL}?access_token=\${GITHUB_OAUTH_TOKEN}\\""
                      |  echo "Response code: \${RESP_CODE}"
                      |  echo "Expected response code: 201"
                      |  exit 1
                      |fi
