import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import React from 'react';
import Colors from '../../constant/Colors';

export default function TopCard() {
    return (
        <View style={styles.card}>
            <View style={styles.header}>
                <Text style={styles.visitorName}>Ranbir Kapoor</Text>
                <Text style={styles.message}>"lorem50"</Text>
                <Text style={styles.time}>10:30 AM</Text>
            </View>
            <View style={styles.buttonsContainer}>
                <TouchableOpacity style={[styles.button, styles.acceptButton]}>
                    <Text style={styles.buttonText}>Accept</Text>
                </TouchableOpacity>
                <TouchableOpacity style={[styles.button, styles.rejectButton]}>
                    <Text style={styles.buttonText}>Reject</Text>
                </TouchableOpacity>
                <TouchableOpacity style={[styles.button, styles.stallButton]}>
                    <Text style={styles.buttonText}>Stall</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    card: {
        backgroundColor: Colors.PRIMARY,
        padding: 20,
        borderRadius: 10,
        marginVertical: 20,
        shadowColor: '#000',
        shadowOpacity: 0.1,
        shadowRadius: 8,
        shadowOffset: { width: 0, height: 4 },
        width: '90%',
        alignSelf: 'center',
    },
    header: {
        marginBottom: 20,
        alignItems: 'center',
    },
    visitorName: {
        fontSize: 20,
        fontWeight: 'bold',
        color: '#fff',
        marginBottom: 5,
    },
    message: {
        fontSize: 16,
        color: '#e0e0e0',
    },
    time: {
        fontSize: 14,
        color: '#ccc',
    },
    buttonsContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    button: {
        flex: 1,
        paddingVertical: 10,
        alignItems: 'center',
        borderRadius: 5,
        marginHorizontal: 5,
    },
    acceptButton: {
        backgroundColor: 'green',
    },
    rejectButton: {
        backgroundColor: 'red',
    },
    stallButton: {
        backgroundColor: 'gray',
    },
    buttonText: {
        color: '#fff',
        fontWeight: 'bold',
    },
});
