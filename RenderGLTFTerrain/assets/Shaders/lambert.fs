#version 330
in vec2 fragTexCoord;
in vec4 fragColor;
in vec3 fragNormal;

uniform sampler2D texture0;
uniform vec4 colDiffuse;

out vec4 finalColor;

const vec3 lightDir = normalize(vec3(1.0, 0.6, 0.3));
const vec3 lightColor = vec3(1.0);
const vec3 ambient = vec3(0.2);

void main() {
    vec4 base = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
    float ndl = max(dot(normalize(fragNormal), lightDir), 0.0);
    vec3 lit = base.rgb * (ambient + lightColor * ndl);
    finalColor = vec4(pow(lit, vec3(1.0/2.2)), base.a);
}