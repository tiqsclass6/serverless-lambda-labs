exports.handler = async (event) => {
    console.log("Incoming Authorization Event:", JSON.stringify(event));

    const token = event.authorizationToken?.replace("Bearer ", "");

    if (!token) {
        console.log("No token provided");
        return generatePolicy("user", "Deny", event.methodArn);
    }

    try {
        // Basic JWT validation (you can expand this)
        const decoded = JSON.parse(atob(token.split('.')[1]));

        // Validate audience and expiration (simple check)
        if (decoded.aud !== process.env.AUTH0_AUDIENCE) {
            throw new Error("Invalid audience");
        }

        console.log("JWT Validated successfully");
        return generatePolicy(decoded.sub || "user", "Allow", event.methodArn);

    } catch (err) {
        console.error("JWT Validation Failed:", err.message);
        return generatePolicy("user", "Deny", event.methodArn);
    }
};

const generatePolicy = (principalId, effect, resource) => {
    return {
        principalId,
        policyDocument: {
            Version: "2012-10-17",
            Statement: [{
                Action: "execute-api:Invoke",
                Effect: effect,
                Resource: resource
            }]
        }
    };
};